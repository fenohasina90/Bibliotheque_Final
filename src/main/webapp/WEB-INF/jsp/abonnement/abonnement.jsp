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
    <link href="/css/abonnement.css" rel="stylesheet">
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
            <a href="/user/" class="nav-link">
                <i class="fas fa-home"></i>
                <span>Home</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/user/abonnement" class="nav-link active">
                <i class="fas fa-id-card"></i>
                <span>Abonnement</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/user/emprunt" class="nav-link">
                <i class="fas fa-hand-holding"></i>
                <span>Emprunt</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/user/reservation" class="nav-link">
                <i class="fas fa-bookmark"></i>
                <span>Réservation</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/user/statistique" class="nav-link">
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