# Collaborate - MyBasecamp Clone

A project management web application inspired by Basecamp, built with Ruby on Rails. Allows teams to collaborate on projects through discussions, task tracking, and file sharing.

## Live Demo

[https://my-basecamp1.onrender.com](https://my-basecamp1.onrender.com)

> **Note:** The free tier app may take 30-60 seconds to wake up on first visit.

## Features

### User Management
- User registration with email validation
- Secure authentication (sign up, sign in, sign out)
- Password requirements (minimum 6 characters)

### Project Management
- Create, edit, and delete projects
- Three project filters: All projects, Created by me, Shared with me
- Project description and metadata

### Team Collaboration
- Add team members by email
- Two permission levels: Admin and Member
- Promote members to admin or remove admin privileges
- Remove members from projects

### Communication
- Create discussion topics within projects
- Real-time messaging in topics
- Message history with author attribution

### Task Tracking
- Create tasks within projects
- Mark tasks as completed
- Visual indication of task status

### File Management
- Upload multiple files to projects
- Download attachments
- Delete attachments

## Tech Stack

- **Backend:** Ruby on Rails 8.1
- **Database:** PostgreSQL
- **Authentication:** Devise
- **File Storage:** Active Storage
- **Frontend:** ERB templates, custom CSS
- **Deployment:** Render.com
- **Version Control:** Git, GitHub, Gitea

## Architecture

### Models
- **User** - Authentication and user data (Devise)
- **Project** - Main entity with name and description
- **Membership** - Join table for users and projects with admin flag
- **Topic** - Discussion threads within projects
- **Message** - Messages within topics
- **Task** - Tasks with completion status
- **Attachment** - File uploads via Active Storage

### Key Relationships
- User has many Projects (created)
- User has many Memberships
- Project belongs to User (creator)
- Project has many Members through Memberships
- Project has many Topics, Tasks, and Attachments
- Topic has many Messages

## Local Setup

### Prerequisites
- Ruby 3.4+
- PostgreSQL 14+
- Node.js 22+
- Git

### Installation

1. Clone the repository:
```bash
   git clone https://github.com/ilKin0609/my-basecamp1.git
   cd my-basecamp1
```

2. Install dependencies:
```bash
   bundle install
```

3. Set up the database:
```bash
   rails db:create
   rails db:migrate
```

4. Start the server:
```bash
   rails server
```

5. Visit `http://localhost:3000`

## Project Structure
app/
├── controllers/      # Request handling logic
├── models/          # Database models and business logic
├── views/           # ERB templates
└── assets/          # Stylesheets and JavaScript
config/
├── routes.rb        # URL routing
├── database.yml     # Database configuration
└── environments/    # Environment-specific settings
db/
└── migrate/         # Database migrations

## Deployment

Deployed on Render.com with:
- Free PostgreSQL database
- Automatic deploys from GitHub main branch
- Environment variables for secrets

## Author

Built as part of the Qwasar bootcamp curriculum.

## License

This project is for educational purposes.
