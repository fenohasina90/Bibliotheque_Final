<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livres Disponibles - Bibliothèque</title>
    <link href="/css/all.min.css" rel="stylesheet">
    <link href="/css/listelivre.css" rel="stylesheet">
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
        <h1><i class="fas fa-book"></i> Bibliothèque Numérique</h1>
        <p class="subtitle">Découvrez notre collection de livres disponibles</p>
    </div>

    <div class="info-bar">
        <div class="info-item">
            <i class="fas fa-calendar-alt"></i>
            <span>Date de recherche: <fmt:formatDate value="${dateRecherche}" pattern="dd/MM/yyyy"/></span>
        </div>
        <div class="info-item">
            <i class="fas fa-user"></i>
            <span>Adhérant ID: ${idAdherant}</span>
        </div>
    </div>

    <div class="search-section">
        <form method="get" action="/user" class="search-form">
            <input type="hidden" name="idAdherant" value="${idAdherant}"/>
            <div class="form-group">
                <label for="date"><i class="fas fa-calendar"></i> Changer la date de recherche</label>
                <input type="date" name="dateStr" id="date" class="form-control"
                       value="<fmt:formatDate value="${dateRecherche}" pattern="yyyy-MM-dd"/>"/>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i> Rechercher
            </button>
        </form>
    </div>

    <c:if test="${not empty livres}">
        <div class="books-count">
            <i class="fas fa-book"></i>
                ${livres.size()} livre(s) trouvé(s)
        </div>
    </c:if>

    <div class="books-container">
        <c:choose>
            <c:when test="${not empty livres}">
                <c:forEach items="${livres}" var="livre">
                    <div class="book-card">
                        <div class="card-header">
                            <span class="id-badge">#${livre.livreId}</span>
                            <c:choose>
                                <c:when test="${livre.disponible > 5}">
                                            <span class="availability available">
                                                <i class="fas fa-check-circle"></i>
                                                Disponible
                                            </span>
                                </c:when>
                                <c:when test="${livre.disponible > 0}">
                                            <span class="availability limited">
                                                <i class="fas fa-exclamation-triangle"></i>
                                                Limité
                                            </span>
                                </c:when>
                                <c:otherwise>
                                            <span class="availability unavailable">
                                                <i class="fas fa-times-circle"></i>
                                                Indisponible
                                            </span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="card-body">
                            <div class="card-content">

                                <div class="book-info">
                                    <h3 class="book-title">${livre.titre}</h3>

                                    <div class="book-stats">
                                        <div class="stat-item">
                                            <span class="stat-value">${livre.exemplaire}</span> exemplaires
                                        </div>
                                        <div class="stat-item">
                                            <span class="stat-value">${livre.disponible}</span> disponibles
                                        </div>
                                    </div>

                                    <div class="card-actions">
                                        <c:choose>
                                            <c:when test="${livre.disponible > 0}">
                                                <form method="post" action="/reservation" style="flex: 1;">
                                                    <input type="hidden" name="livreId" value="${livre.livreId}"/>
                                                    <input type="hidden" name="idAdherant" value="${idAdherant}"/>
                                                    <button type="submit" class="btn btn-reserve btn-icon">
                                                        <i class="fas fa-bookmark"></i>
                                                        Réserver
                                                    </button>
                                                </form>
                                                <form method="post" action="/user/emprunter" style="flex: 1;">
                                                    <input type="hidden" name="livreId" value="${livre.livreId}"/>
                                                    <input type="hidden" name="idAdherant" value="${idAdherant}"/>
                                                    <button type="submit" class="btn btn-borrow btn-icon">
                                                        <i class="fas fa-hand-holding"></i>
                                                        Emprunter
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-reserve btn-icon" disabled>
                                                    <i class="fas fa-bookmark"></i>
                                                    Réserver
                                                </button>
                                                <button class="btn btn-borrow btn-icon" disabled>
                                                    <i class="fas fa-hand-holding"></i>
                                                    Emprunter
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-search"></i>
                    <h3>Aucun livre trouvé</h3>
                    <p>Aucun livre n'est disponible pour cette date.</p>
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
            if (link.getAttribute('href') === currentPath) {
                link.classList.add('active');
            }
        });
    }

    // Animation d'entrée pour les cartes
    document.addEventListener('DOMContentLoaded', function() {
        setActiveNavLink();

        const cards = document.querySelectorAll('.book-card');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            setTimeout(() => {
                card.style.transition = 'all 0.6s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 150);
        });
    });

    // Validation du formulaire de recherche
    document.querySelector('.search-form').addEventListener('submit', function(e) {
        const dateInput = document.getElementById('date');
        if (!dateInput.value) {
            e.preventDefault();
            alert('Veuillez sélectionner une date.');
            dateInput.focus();
        }
    });

    // Confirmation pour les actions
    document.querySelectorAll('form[action*="/reservation"]').forEach(form => {
        form.addEventListener('submit', function(e) {
            const bookTitle = this.closest('.book-card').querySelector('.book-title').textContent;
            if (!confirm(`Êtes-vous sûr de vouloir réserver "${bookTitle}" ?`)) {
                e.preventDefault();
            }
        });
    });

    document.querySelectorAll('form[action*="/emprunter"]').forEach(form => {
        form.addEventListener('submit', function(e) {
            const bookTitle = this.closest('.book-card').querySelector('.book-title').textContent;
            if (!confirm(`Êtes-vous sûr de vouloir emprunter "${bookTitle}" ?`)) {
                e.preventDefault();
            }
        });
    });

    // Effet de feedback visuel après action
    function showFeedback(message, type) {
        const feedback = document.createElement('div');
        feedback.className = `alert alert-${type}`;
        feedback.style.cssText = `
                    position: fixed;
                    top: 90px;
                    right: 20px;
                    padding: 15px 20px;
                    border-radius: 8px;
                    color: white;
                    font-weight: 600;
                    z-index: 1000;
                    animation: slideIn 0.3s ease;
                `;
        feedback.style.background = type === 'success' ? '#28a745' : '#dc3545';
        feedback.textContent = message;
        document.body.appendChild(feedback);

        setTimeout(() => {
            feedback.remove();
        }, 3000);
    }

    // Style pour l'animation
    const style = document.createElement('style');
    style.textContent = `
                @keyframes slideIn {
                    from { transform: translateX(100%); opacity: 0; }
                    to { transform: translateX(0); opacity: 1; }
                }
            `;
    document.head.appendChild(style);
</script>
</body>
</html>