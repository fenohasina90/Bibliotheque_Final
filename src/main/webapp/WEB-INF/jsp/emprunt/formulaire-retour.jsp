<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Retour de livre</title>
</head>
<body>
<h2>Retour du livre ${emprunt.livre.titre}</h2>

<form action="/emprunts/retour/${emprunt.id}" method="post">
    <label for="dateRetour">Date de retour :</label>
    <input id="dateRetour" type="date" name="dateRetour" value="${dateRetour}" required>

    <button type="submit">Valider le retour</button>
</form>
</body>
</html>