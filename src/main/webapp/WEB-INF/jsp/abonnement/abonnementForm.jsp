<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un Abonnement</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .form-container {
            background-color: white;
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
            padding: 10px;
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
            padding: 12px 30px;
            margin: 0 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
        }
        .success {
            color: #28a745;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h1>Créer un Nouvel Abonnement</h1>

    <%
        String message = request.getParameter("message");
        if (message != null && message.equals("success")) {
    %>
    <div class="success">
        Abonnement créé avec succès !
    </div>
    <%
        }
    %>

    <form action="/abonnement/traitement" method="post">
        <div class="form-group">
            <label for="date_debut">Date de début :</label>
            <input type="date" name="dateDebut" id="date_debut" required>
        </div>

        <div class="form-group">
            <label for="date_fin">Date de fin :</label>
            <input type="date" name="dateFin" id="date_fin" required>
        </div>

        <div class="btn-container">
            <button type="submit" class="btn btn-primary">Créer l'abonnement</button>
            <a href="abonnement.jsp" class="btn btn-secondary">Annuler</a>
        </div>
    </form>
</div>

<script>

    // Définir la date de début par défaut à aujourd'hui
    document.getElementById('date_debut').valueAsDate = new Date();

    // Définir la date de fin par défaut à dans 1 an
    const dateFinDefaut = new Date();
    dateFinDefaut.setFullYear(dateFinDefaut.getFullYear() + 1);
    document.getElementById('date_fin').valueAsDate = dateFinDefaut;
</script>
</body>
</html>