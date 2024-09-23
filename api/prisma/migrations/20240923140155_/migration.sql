-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY
);

-- CreateTable
CREATE TABLE "Task" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "labelId" TEXT,
    "description" TEXT NOT NULL,
    "dueDate" TEXT,
    "dateCreated" TEXT NOT NULL,
    "hasDueTime" BOOLEAN NOT NULL,
    "hasDueDate" BOOLEAN NOT NULL,
    "isCompleted" BOOLEAN NOT NULL,
    "isDeleted" BOOLEAN NOT NULL,
    "isClassroomCourseWork" BOOLEAN NOT NULL,
    "courseWorkLink" TEXT,
    "courseWorkId" TEXT,
    "courseWorkTitle" TEXT,
    "courseWorkDescription" TEXT,
    "courseId" TEXT,
    CONSTRAINT "Task_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Task_labelId_fkey" FOREIGN KEY ("labelId") REFERENCES "Label" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Label" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "isGCLabel" BOOLEAN NOT NULL,
    "courseId" TEXT,
    "courseName" TEXT,
    CONSTRAINT "Label_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
