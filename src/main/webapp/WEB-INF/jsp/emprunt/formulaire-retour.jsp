<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Retour de livre</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center">Retour du livre ${emprunt.livre.titre}</h3>
                </div>
                <div class="card-body">
                    <form action="/emprunts/retour/${emprunt.id}" method="POST">
                        <div class="mb-3">
                            <label for="dateRetour" class="form-label">Date de retour :</label>
                            <input id="dateRetour" type="date" name="dateRetour" value="${dateRetour}" class="form-control" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Valider le retour</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>