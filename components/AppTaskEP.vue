<template>
  <v-expansion-panel v-show="task.isDeleted === false">
    <v-expansion-panel-header class="py-1">
      <v-list class="ma-0 pa-0" max-width="95%">
        <v-list-item class="ma-0 pa-0" style="max-width: 98%">
          <v-row no-gutters class="ma-0 pa-0" style="max-width: 100%">
            <v-col cols="10">
              <v-list-item-content>
                <v-list-item-subtitle :class="listItemTitleProp">
                  {{ label }}
                </v-list-item-subtitle>
                <v-list-item-title class="body-2" :class="listItemTitleProp">
                  <div class="text-truncate">
                    {{ task.title }}
                  </div>
                </v-list-item-title>
                <v-list-item-subtitle>
                  <span :class="listItemTitleProp">
                    {{ dueTime }}
                  </span>
                  <v-btn-tooltip v-if="task.isClassroomCourseWork" tooltip="See GC Assignment" icon x-small :target="targetRedirect" :href="task.courseWorkLink" class-btn="ml-1 " @click.stop>
                    <v-icon>mdi-google-classroom</v-icon>
                  </v-btn-tooltip>
                </v-list-item-subtitle>
              </v-list-item-content>
            </v-col>
            <v-col cols="2" align-self="center">
              <v-row no-gutters justify="end">
                <v-col cols="6">
                  <v-btn-tooltip tooltip="Edit" icon small class-btn="col-1" @click.stop="editBtnClick">
                    <!--With data parameters later-->
                    <v-icon>mdi-pencil</v-icon>
                  </v-btn-tooltip>
                </v-col>
                <v-col cols="6">
                  <v-btn-tooltip :tooltip="!EPDisabled ? 'Mark As Done': 'Mark As Not Done'" icon small class-btn="col-1 ml-1" @click.stop="markAsDoneBtnClick">
                    <v-icon>{{ markAsDoneIconName }}</v-icon>
                  </v-btn-tooltip>
                </v-col>
              </v-row>
            </v-col>
          </v-row>
        </v-list-item>
      </v-list>
      <template #actions>
        <v-icon>
          mdi-chevron-down
        </v-icon>
      </template>
    </v-expansion-panel-header>
    <v-expansion-panel-content>
      <p class=" my-0 px-0 subtitle-2">
        Description
      </p>
      <v-row no-gutters>
        <v-col class="text-truncate py-0 pl-0 caption" cols="12" style="user-select: none; cursor: pointer" @click="showDescDialog=true">
          {{ task.description ? task.description : task.isClassroomCourseWork ? task.courseWorkDescription : '' }}
        </v-col>
      </v-row>
    </v-expansion-panel-content>
    <AppTaskEPEditDialog
      v-model="showEditDialog"
      :task="task"
      @closeEditDialog="showEditDialog=false"
    />
    <AppTaskEPDescDialog
      v-model="showDescDialog"
      :task="task"
    />
  </v-expansion-panel>
</template>

<script>
import { mapActions } from 'vuex'
import moment from 'moment'

export default {
  name: 'AppTaskEP',
  props: {
    task: {
      type: Object,
      default() {
        return { id: undefined }
      }
    }
  },
  data() {
    return {

      EPDisabled: this.task.isCompleted,
      showDescDialog: false,
      showEditDialog: false,
      dueTime: this.task.hasDueTime ? moment(this.task.dueDate).local().format('[Due] HH:mm') : ''
    }
  },
  computed: {
    label() {
      let labels = this.$store.state.entries.labels
      if (this.task.isClassroomCourseWork) {
        let label = this.findClassLabel(this.task, labels)
        if (label) {
          return label.name
        } else {
          return ''
        }
      } else {
        let label = this.findLabel(this.task, labels)
        if (label) {
          return label.name
        } else {
          return ''
        }
      }
    },
    targetRedirect() {
      if (window.innerWidth < 960) {
        return '_self'
      }
      return '_blank'
    },
    listItemTitleProp() {
      return this.EPDisabled ? 'text-decoration-line-through green--text' : ''
    },
    markAsDoneIconName() {
      return this.EPDisabled ? 'mdi-close' : 'mdi-check'
    }
  },
  methods: {
    ...mapActions('entries', ['updateTask']),
    moment() {
      return moment();
    },
    findClassLabel(task, labels) {
      const label = labels.find(label => label.courseId === task.courseId);

      return label
    },
    findLabel(task, labels) {
      const label = labels.find(label => label.id === task.labelId);
      return label
    },
    actionBtnClick() {
      this.$emit('action-btn-click')
    },
    editBtnClick() {
      this.showEditDialog = true
    },
    markAsDoneBtnClick() {
      this.actionBtnClick();
      this.$emit('checkmark-btn-click')
      this.toggleCompletion()
      this.EPDisabled = !this.EPDisabled;
    },
    async toggleCompletion() {
      let newTask = Object.assign({}, this.task);
      newTask.isCompleted = !newTask.isCompleted
      await this.updateTask(newTask)
    }
  }
}

</script>
