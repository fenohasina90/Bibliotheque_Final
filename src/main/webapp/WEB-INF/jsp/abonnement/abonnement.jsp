<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Abonnements - Bibliothèque</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-top: 80px;
            padding-left: 20px;
            padding-right: 20px;
            padding-bottom: 20px;
            line-height: 1.6;
        }

        /* Navbar Styles */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            padding: 0 20px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            text-decoration: none;
        }

        .navbar-brand i {
            font-size: 1.8rem;
            color: #3498db;
        }

        .navbar-nav {
            display: flex;
            align-items: center;
            gap: 0;
            list-style: none;
        }

        .nav-item {
            position: relative;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 0 2px;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            transform: translateY(-1px);
        }

        .nav-link.active {
            background: rgba(52, 152, 219, 0.2);
            color: #3498db;
            font-weight: 600;
        }

        .nav-link i {
            font-size: 1.1rem;
        }

        .navbar-toggle {
            display: none;
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            padding: 5px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #e67e22 0%, #f39c12 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: pulse 4s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }

        .header .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .stats-bar {
            background: #f8f9fa;
            padding: 20px 30px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-around;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .stat-item {
            text-align: center;
            padding: 15px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            min-width: 150px;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #2c3e50;
            display: block;
        }

        .stat-label {
            font-size: 0.9rem;
            color: #6c757d;
            margin-top: 5px;
        }

        .stat-icon {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .stat-item.active {
            color: #28a745;
        }

        .stat-item.expired {
            color: #dc3545;
        }

        .stat-item.expiring {
            color: #ffc107;
        }

        .filter-section {
            padding: 30px;
            background: #ffffff;
            border-bottom: 1px solid #e9ecef;
        }

        .filter-form {
            display: flex;
            gap: 15px;
            align-items: end;
            flex-wrap: wrap;
            max-width: 800px;
            margin: 0 auto;
        }

        .form-group {
            flex: 1;
            min-width: 150px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus {
            outline: none;
            border-color: #3498db;
            background: white;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
        }

        .abonnements-count {
            background: #e9ecef;
            padding: 15px 30px;
            text-align: center;
            font-weight: 600;
            color: #495057;
            border-bottom: 1px solid #dee2e6;
        }

        .abonnements-count i {
            color: #f39c12;
            margin-right: 8px;
        }

        .abonnements-container {
            padding: 30px;
        }

        .abonnements-table {
            width: 100%;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .table-header {
            background: linear-gradient(135deg, #34495e, #2c3e50);
            color: white;
            padding: 20px;
            font-weight: 600;
        }

        .table-row {
            display: grid;
            grid-template-columns: 80px 1fr 120px 120px 120px 150px;
            gap: 20px;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
            transition: background 0.2s ease;
        }

        .table-row:hover {
            background: #f8f9fa;
        }

        .table-row:last-child {
            border-bottom: none;
        }

        .subscription-id {
            font-weight: 600;
            color: #6c757d;
            font-family: monospace;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3498db, #2980b9);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .user-details h4 {
            margin: 0;
            font-size: 1rem;
            color: #2c3e50;
        }

        .user-details p {
            margin: 0;
            font-size: 0.85rem;
            color: #6c757d;
        }

        .date-info {
            text-align: center;
            font-size: 0.9rem;
        }

        .date-value {
            font-weight: 600;
            color: #2c3e50;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-expired {
            background: #f8d7da;
            color: #721c24;
        }

        .status-expiring {
            background: #fff3cd;
            color: #856404;
        }

        .actions {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.8rem;
            border-radius: 6px;
        }

        .btn-outline-primary {
            background: transparent;
            color: #3498db;
            border: 1px solid #3498db;
        }

        .btn-outline-primary:hover {
            background: #3498db;
            color: white;
        }

        .btn-outline-success {
            background: transparent;
            color: #28a745;
            border: 1px solid #28a745;
        }

        .btn-outline-success:hover {
            background: #28a745;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #dee2e6;
        }

        .empty-state h3 {
            margin-bottom: 10px;
            color: #495057;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                padding: 0 15px;
            }

            .navbar-nav {
                position: fixed;
                top: 70px;
                left: 0;
                right: 0;
                background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
                flex-direction: column;
                padding: 20px;
                transform: translateY(-100%);
                transition: transform 0.3s ease;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            .navbar-nav.active {
                transform: translateY(0);
            }

            .navbar-toggle {
                display: block;
            }

            .nav-link {
                padding: 15px 0;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                margin: 0;
                justify-content: center;
            }

            .nav-link:last-child {
                border-bottom: none;
            }

            body {
                padding-top: 70px;
            }

            .container {
                margin: 10px;
                border-radius: 15px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .stats-bar {
                flex-direction: column;
            }

            .filter-form {
                flex-direction: column;
            }

            .form-group {
                min-width: 100%;
            }

            .table-row {
                grid-template-columns: 1fr;
                gap: 10px;
                text-align: center;
            }

            .user-info {
                justify-content: center;
            }

            .actions {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar">
    <a href="#" class="navbar-brand">
        <i class="fas fa-book"></i>
        Bibliothèque
    </a>

    <button class="navbar-toggle" onclick="toggleNavbar()">
        <i class="fas fa-bars"></i>
    </button>

    <ul class="navbar-nav" id="navbarNav">
        <li class="nav-item">
            <a href="/home" class="nav-link">
                <i class="fas fa-home"></i>
                <span>Home</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/abonnement" class="nav-link active">
                <i class="fas fa-id-card"></i>
                <span>Abonnement</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/emprunt" class="nav-link">
                <i class="fas fa-hand-holding"></i>
                <span>Emprunt</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/reservation" class="nav-link">
                <i class="fas fa-bookmark"></i>
                <span>Réservation</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/statistique" class="nav-link">
                <i class="fas fa-chart-bar"></i>
                <span>Statistiques</span>
            </a>
        </li>
    </ul>
</nav>

<div class="container">
    <div class="header">
        <h1><i class="fas fa-id-card"></i> Mes Abonnements</h1>
        <p class="subtitle">Consultez vos abonnements à la bibliothèque</p>
    </div>

    <!-- Statistiques - Calculées dynamiquement -->
    <div class="stats-bar">
        <c:set var="actifsCount" value="0"/>
        <c:set var="expiresCount" value="0"/>
        <c:set var="expireBientotCount" value="0"/>
        <c:set var="totalCount" value="${not empty listes ? listes.size() : 0}"/>

    </div>

    <!-- Filtres -->
    <div class="filter-section">
        <form method="get" action="/abonnement" class="filter-form">
            <div class="form-group">
                <label for="dateDebut"><i class="fas fa-calendar-alt"></i> Date Début</label>
                <input type="date" name="dateDebut" id="dateDebut" class="form-control" value="${param.dateDebut}"/>
            </div>
            <div class="form-group">
                <label for="dateFin"><i class="fas fa-calendar-alt"></i> Date Fin</label>
                <input type="date" name="dateFin" id="dateFin" class="form-control" value="${param.dateFin}"/>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i> Filtrer
            </button>
            <a href="/abonnement/form" class="btn btn-success">
                <i class="fas fa-plus"></i> Nouvel Abonnement
            </a>
        </form>
    </div>

    <!-- Nombre d'abonnements -->
    <c:if test="${not empty listes}">
        <div class="abonnements-count">
            <i class="fas fa-id-card"></i>
                ${listes.size()} abonnement(s) trouvé(s)
        </div>
    </c:if>

    <!-- Liste des abonnements -->
    <div class="abonnements-container">
        <c:choose>
            <c:when test="${not empty listes}">
                <div class="abonnements-table">
                    <div class="table-header">
                        <div class="table-row">
                            <div>ID</div>
                            <div>Utilisateur</div>
                            <div>Date Début</div>
                            <div>Date Fin</div>
                            <div>Actions</div>
                        </div>
                    </div>

                    <c:forEach items="${listes}" var="abonnement">
                        <div class="table-row">
                            <div class="subscription-id">#${abonnement.id}</div>

                            <div class="user-info">
                                <div class="user-avatar">
                                    <c:choose>
                                        <c:when test="${not empty abonnement.utilisateur.prenom and not empty abonnement.utilisateur.nom}">
                                            ${abonnement.utilisateur.prenom.substring(0,1)}${abonnement.utilisateur.nom.substring(0,1)}
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-user"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="user-details">
                                    <h4>
                                        <c:choose>
                                            <c:when test="${not empty abonnement.utilisateur.prenom and not empty abonnement.utilisateur.nom}">
                                                ${abonnement.utilisateur.prenom} ${abonnement.utilisateur.nom}
                                            </c:when>
                                            <c:otherwise>
                                                Utilisateur inconnu
                                            </c:otherwise>
                                        </c:choose>
                                    </h4>
                                    <p>ID: ${abonnement.utilisateur.nom}</p>
                                </div>
                            </div>

                            <div class="date-info">
                                <div class="date-value">
                                        ${abonnement.dateDebut.toString()} <!-- Affichera "2025-07-04" -->
                                </div>
                            </div>
                            <div class="date-info">
                            <div class="date-value">
                                    ${abonnement.dateFin.toString()} <!-- Affichera "2025-07-04" -->
                            </div>
                        </div>

                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-id-card"></i>
                    <h3>Aucun abonnement trouvé</h3>
                    <p>Vous n'avez actuellement aucun abonnement à la bibliothèque.</p>
                    <a href="/abonnement/form" class="btn btn-success" style="margin-top: 20px;">
                        <i class="fas fa-plus"></i> Créer un abonnement
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    // Fonction pour basculer la navbar mobile
    function toggleNavbar() {
        const navbarNav = document.getElementById('navbarNav');
        navbarNav.classList.toggle('active');
    }

    // Fermer la navbar mobile lors du clic sur un lien
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', () => {
            const navbarNav = document.getElementById('navbarNav');
            navbarNav.classList.remove('active');
        });
    });

    // Gestion de l'état actif des liens de navigation
    function setActiveNavLink() {
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.nav-link');

        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === currentPath ||
                (currentPath.includes('/abonnement') && link.getAttribute('href') === '/abonnement')) {
                link.classList.add('active');
            }
        });
    }

    // Animation d'entrée pour les lignes du tableau
    document.addEventListener('DOMContentLoaded', function() {
        setActiveNavLink();

        const rows = document.querySelectorAll('.table-row');
        rows.forEach((row, index) => {
            if (index === 0) return; // Skip header
            row.style.opacity = '0';
            row.style.transform = 'translateX(-30px)';
            setTimeout(() => {
                row.style.transition = 'all 0.6s ease';
                row.style.opacity = '1';
                row.style.transform = 'translateX(0)';
            }, (index - 1) * 100);
        });
    });

    // Confirmation pour les actions de renouvellement
    document.querySelectorAll('a[href*="/renouveler/"]').forEach(link => {
        link.addEventListener('click', function(e) {
            const userInfo = this.closest('.table-row').querySelector('.user-details h4').textContent;
            if (!confirm(`Êtes-vous sûr de vouloir renouveler l'abonnement de ${userInfo} ?`)) {
                e.preventDefault();
            }
        });
    });

    // Validation du formulaire de filtrage
    document.querySelector('.filter-form').addEventListener('submit', function(e) {
        const dateDebut = document.getElementById('dateDebut').value;
        const dateFin = document.getElementById('dateFin').value;

        if (dateDebut && dateFin && dateDebut > dateFin) {
            e.preventDefault();
            alert('La date de début ne peut pas être postérieure à la date de fin.');
            return;
        }
    });

    // Mise à jour automatique des statistiques (simulation)
    function updateStats() {
        const statValues = document.querySelectorAll('.stat-value');
        statValues.forEach(stat => {
            stat.style.animation = 'pulse 0.5s ease-in-out';
            setTimeout(() => {
                stat.style.animation = '';
            }, 500);
        });
    }

    // Actualisation des stats toutes les 30 secondes (optionnel)
    // setInterval(updateStats, 30000);
</script>
</body>
</html>