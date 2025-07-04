<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .sidebar {
            height: 100vh;
            background: #343a40;
            color: white;
            position: fixed;
            width: 250px;
            transition: all 0.3s;
        }
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 5px;
            border-radius: 5px;
        }
        .sidebar .nav-link:hover {
            background: #495057;
            color: white;
        }
        .sidebar .nav-link.active {
            background: #007bff;
            color: white;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            width: calc(100% - 250px);
        }
        .sidebar-header {
            padding: 20px;
            background: #2c3136;
        }
        .sidebar-header h3 {
            color: white;
            margin-bottom: 0;
        }
        .logo {
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header d-flex align-items-center">
        <img src="https://via.placeholder.com/40" alt="Logo" class="logo">
        <h3>Admin Dashboard</h3>
    </div>
    <ul class="nav flex-column px-3 pt-3">
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-tachometer-alt"></i> Tableau de bord
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="#abonnements">
                <i class="fas fa-id-card"></i> Abonnements
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#reservations">
                <i class="fas fa-calendar-check"></i> Réservations
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#prets">
                <i class="fas fa-book"></i> Prêts
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#utilisateurs">
                <i class="fas fa-users"></i> Utilisateurs
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#parametres">
                <i class="fas fa-cog"></i> Paramètres
            </a>
        </li>
        <li class="nav-item mt-3">
            <a class="nav-link text-danger" href="#deconnexion">
                <i class="fas fa-sign-out-alt"></i> Déconnexion
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Gestion des Abonnements</h2>
            <button class="btn btn-primary">
                <i class="fas fa-plus"></i> Ajouter
            </button>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Email</th>
                            <th>Type</th>
                            <th>Date début</th>
                            <th>Date fin</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1</td>
                            <td>Jean Dupont</td>
                            <td>jean.dupont@example.com</td>
                            <td>Annuel</td>
                            <td>01/01/2023</td>
                            <td>01/01/2024</td>
                            <td><span class="badge bg-success">Actif</span></td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary"><i class="fas fa-edit"></i></button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        <!-- Ajoutez d'autres lignes selon vos besoins -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Script pour gérer l'état actif des liens
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', function() {
            document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });
    });
</script>
</body>
</html>