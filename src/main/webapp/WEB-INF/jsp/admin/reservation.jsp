<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord Admin</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/all.min.css">
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
            <a class="nav-link" href="/admin">
                <i class="fas fa-id-card"></i> Abonnements
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="/admin/reservation">
                <i class="fas fa-calendar-check"></i> Réservations
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/emprunts">
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
            <h2>Gestion des Réservations</h2>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                        <tr>
                            <th>Nom Utilisateur</th>
                            <th>Titre livre</th>
                            <th>Date Reservation</th>
                            <th>Statut</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="reservation" items="${listes}">
                            <tr>
                                <td>${reservation.nom}</td>
                                <td>${reservation.titre}</td>
                                <td>${reservation.dateReservation}</td>
                                <td>
                                    <span class="badge ${reservation.statut == 'En attente' ? 'bg-warning' : 
                                                       reservation.statut == 'Validee' ? 'bg-success' :
                                                       reservation.statut == 'Refusee' ? 'bg-danger' :
                                                       reservation.statut == 'Terminee' ? 'bg-info' : 'bg-secondary'}">
                                        ${reservation.statut}
                                    </span>
                                </td>
                                <td>
                                    <!-- Action Historique (toujours disponible) -->
                                    <button class="btn btn-sm btn-outline-info" title="Historique">
                                        <i class="fas fa-history"></i>
                                    </button>
                                    
                                    <!-- Action Annuler (seulement si statut = Validé ou En attente) -->
                                    <c:if test="${reservation.statut == 'Validé' || reservation.statut == 'En attente'}">
                                        <form method="post" action="/admin/reservation/terminerstatut" style="display: inline;">
                                            <input type="hidden" name="idReservation" value="${reservation.id}">
                                            <button type="submit" class="btn btn-sm btn-outline-warning" title="Annuler" 
                                                    onclick="return confirm('Êtes-vous sûr de vouloir annuler cette réservation ?')">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                    
                                    <!-- Actions Valider/Refuser (seulement si statut = En attente) -->
                                    <c:if test="${reservation.statut == 'En attente'}">
                                        <form method="post" action="/admin/reservation/validestatut" style="display: inline;">
                                            <input type="hidden" name="idReservation" value="${reservation.id}">
                                            <button type="submit" class="btn btn-sm btn-outline-success" title="Valider">
                                                <i class="fas fa-check"></i>
                                            </button>
                                        </form>
                                        
                                        <form method="post" action="/admin/reservation/refuserstatut" style="display: inline;">
                                            <input type="hidden" name="idReservation" value="${reservation.id}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger" title="Refuser">
                                                <i class="fas fa-ban"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/js/bootstrap.bundle.min.js"></script>
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