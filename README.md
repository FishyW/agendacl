# AgendaCL

AgendaCL (temporary name) is a web application that allows you to create, edit and delete tasks. Its main feature is its ability to synchronize with Google Classroom. Labels also allow you to identify a task by its course name.

## Installation For Developers

Install using npm package manager.

```bash
npm install
```

Create a dot env file inside the directory and put in the Database URL Environment while replacing the parameters.

```env
# PSQL
DATABASE_URL="postgresql://username:password@localhost:5432/db?=schema=myschema"
# SQLite
DATABASE_URL="file:./dev.db"
```

Run prisma migrate, then generate to configure the database.

```bash
npm run migrate
npm run generate
```
To use the app, run

```bash
npm run dev
```

Alternatively, to test the app in production mode, run
```bash
npm run build
npm run start
```

## Website
Visit the [AgendaCL](https://agendacl.herokuapp.com/) website to use the web app.

Development Server: [AgendaCL Dev](https://agendacl-dev.herokuapp.com/)

## Authors and acknowledgment

IMHCWinston

nicholasalden
