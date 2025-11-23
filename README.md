# 🍕 Go Pizza Tracker

![Go Version](https://img.shields.io/github/go-mod/go-version/bouzayenilyes/go-pizza-tracker)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Status](https://img.shields.io/badge/status-active-success.svg)

> A real-time pizza order tracking application built with Go, Gin, and GORM. Experience the journey of your pizza from the kitchen to your doorstep with live updates!

---

## 📖 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the Application](#running-the-application)
- [Project Structure](#-project-structure)
- [API Endpoints](#-api-endpoints)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

- **Real-time Order Tracking**: Receive live updates on your order status using Server-Sent Events (SSE).
- **Interactive Admin Dashboard**: Manage orders, update statuses, and view notifications in real-time.
- **Order Management**: Create, update, and delete orders seamlessly.
- **Customer Notifications**: Customers get instant feedback on their order progress.
- **Secure Authentication**: Admin login system to protect sensitive operations.
- **Responsive Design**: Beautifully crafted UI that works on desktop and mobile.

---

## 🛠 Tech Stack

This project leverages a powerful modern stack to ensure performance and reliability:

- **Backend**: [Go](https://golang.org/) (Golang)
- **Web Framework**: [Gin Gonic](https://gin-gonic.com/) - High-performance HTTP web framework.
- **Database ORM**: [GORM](https://gorm.io/) - The fantastic ORM library for Golang.
- **Database**: [SQLite](https://www.sqlite.org/index.html) - Lightweight, disk-based database (configurable).
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla).
- **Real-time**: Server-Sent Events (SSE) for live updates.
- **Utilities**: `shortid` for unique order IDs, `slog` for structured logging.

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

Ensure you have Go installed on your system.
- **Go 1.24+** is required.

Check your Go version:
```bash
go version
```

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/bouzayenilyes/go-pizza-tracker.git
   cd go-pizza-tracker
   ```

2. **Install dependencies**
   ```bash
   go mod download
   ```

### Running the Application

1. **Start the server**
   ```bash
   go run cmd/*.go
   ```

2. **Access the application**
   Open your browser and navigate to:
   - **Customer View**: [http://localhost:3000](http://localhost:3000)
   - **Admin Dashboard**: [http://localhost:3000/admin](http://localhost:3000/admin)

> **Note**: The default port is `3000`. You can configure this in your environment variables or config file if applicable.

---

## 📂 Project Structure

```
go-pizza-tracker/
├── cmd/
│   ├── main.go           # Application entry point
│   ├── routes.go         # Route definitions
│   ├── handlers.go       # HTTP handlers
│   └── ...
├── internal/
│   └── models/           # Database models and business logic
├── templates/            # HTML templates and static assets
├── data/                 # SQLite database file (created at runtime)
├── go.mod                # Go module definition
└── README.md             # Project documentation
```

---

## 🔌 API Endpoints

### Public
- `GET /` - Home page / Order form
- `POST /new-order` - Submit a new order
- `GET /customer/:id` - Track a specific order
- `GET /notifications` - SSE stream for notifications
- `GET /login` - Admin login page
- `POST /login` - Admin login action

### Admin (Protected)
- `GET /admin` - Admin dashboard
- `POST /admin/order/:id/update` - Update order status
- `POST /admin/order/:id/delete` - Delete an order
- `GET /admin/notifications` - Admin SSE stream

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/bouzayenilyes">Bouzayen Ilyes</a>
</p>
