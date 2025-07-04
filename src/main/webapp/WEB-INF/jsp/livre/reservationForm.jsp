<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Réservation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        select, input[type="date"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }

        select:focus, input[type="date"]:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
        }

        .btn-container {
            text-align: center;
            margin-top: 30px;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 10px;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .btn-secondary {
            background-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .error {
            color: #d32f2f;
            font-size: 14px;
            margin-top: 5px;
        }

        .success {
            color: #2e7d32;
            background-color: #e8f5e8;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h1>Nouvelle Réservation</h1>
    <form method="POST" action="${pageContext.request.contextPath}/reservation/create">
        <div class="form-group">
            <label for="date_debut">Date de début :</label>
            <input id="date_debut" type="date" name="dateDebut" required />
            <input type="hidden" name="livreId" value="${livreId}" />
        </div>

        <div class="btn-container">
            <button type="submit" class="btn">Créer la réservation</button>
            <button type="button" class="btn btn-secondary" onclick="window.location.href='/livre'">
                Annuler
            </button>
        </div>
        <c:if test="${not empty erreur}">
            <div class="alert alert-danger text-center">${erreur}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success text-center">${success}</div>
        </c:if>
    </form>
</div>

<script>
    // Définir la date minimum à aujourd'hui
    document.addEventListener('DOMContentLoaded', function() {
        const dateInput = document.getElementById('date_debut');
        const today = new Date().toISOString().split('T')[0];
        dateInput.setAttribute('min', today);
        dateInput.value = today;
    });
</script>
</body>
</html>