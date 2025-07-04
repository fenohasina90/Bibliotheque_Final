<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livres Disponibles - Bibliothèque</title>
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
            padding: 20px;
            line-height: 1.6;
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
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
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

        .info-bar {
            background: #f8f9fa;
            padding: 20px 30px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            color: #495057;
        }

        .info-item i {
            color: #3498db;
            font-size: 1.1rem;
        }

        .search-section {
            padding: 30px;
            background: #ffffff;
            border-bottom: 1px solid #e9ecef;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: end;
            flex-wrap: wrap;
            max-width: 600px;
            margin: 0 auto;
        }

        .form-group {
            flex: 1;
            min-width: 200px;
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

        .books-container {
            padding: 30px;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .book-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.2s ease;
            border: 1px solid #e0e0e0;
        }

        .book-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            background: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-body {
            padding: 20px;
        }

        .card-content {
            display: flex;
            gap: 15px;
            align-items: flex-start;
        }

        .book-image-container {
            flex-shrink: 0;
        }

        .book-image {
            width: 60px;
            height: 80px;
            object-fit: cover;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .book-info {
            flex: 1;
        }

        .book-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .book-stats {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            font-size: 0.9rem;
        }

        .stat-item {
            color: #666;
        }

        .stat-value {
            font-weight: 600;
            color: #333;
        }

        .card-actions {
            display: flex;
            gap: 10px;
        }

        .btn-reserve {
            background: #28a745;
            color: white;
            flex: 1;
            font-size: 0.9rem;
            padding: 10px 15px;
        }

        .btn-reserve:hover {
            background: #218838;
        }

        .btn-borrow {
            background: #007bff;
            color: white;
            flex: 1;
            font-size: 0.9rem;
            padding: 10px 15px;
        }

        .btn-borrow:hover {
            background: #0056b3;
        }

        .btn:disabled {
            background: #6c757d !important;
            cursor: not-allowed;
        }

        .btn-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .availability {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 8px;
            border-radius: 12px;
            font-weight: 500;
            font-size: 0.85rem;
        }

        .availability.available {
            background: #d4edda;
            color: #155724;
        }

        .availability.limited {
            background: #fff3cd;
            color: #856404;
        }

        .availability.unavailable {
            background: #f8d7da;
            color: #721c24;
        }

        .id-badge {
            background: #e9ecef;
            color: #495057;
            padding: 3px 8px;
            border-radius: 6px;
            font-family: monospace;
            font-size: 0.85rem;
        }

        .no-image {
            width: 60px;
            height: 80px;
            background: #f8f9fa;
            border: 2px dashed #dee2e6;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 1.2rem;
        }

        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 40px 20px;
            color: #6c757d;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .empty-state i {
            font-size: 2rem;
            margin-bottom: 15px;
            color: #dee2e6;
        }

        .books-count {
            background: #e9ecef;
            padding: 15px 30px;
            text-align: center;
            font-weight: 600;
            color: #495057;
            border-bottom: 1px solid #dee2e6;
        }

        .books-count i {
            color: #3498db;
            margin-right: 8px;
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
                border-radius: 15px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .info-bar {
                flex-direction: column;
                align-items: flex-start;
            }

            .search-form {
                flex-direction: column;
            }

            .form-group {
                min-width: 100%;
            }

            .books-container {
                grid-template-columns: 1fr;
                padding: 20px;
                gap: 15px;
            }

            .card-content {
                flex-direction: column;
                text-align: center;
            }

            .book-stats {
                justify-content: center;
            }
        }

        .loading {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }

        .loading i {
            font-size: 2rem;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
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
        <form method="get" action="/livre" class="search-form">
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
                                                <form method="post" action="/livre/emprunter" style="flex: 1;">
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
    // Animation d'entrée pour les cartes
    document.addEventListener('DOMContentLoaded', function() {
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
    document.querySelectorAll('form[action*="/reserver"]').forEach(form => {
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
                top: 20px;
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