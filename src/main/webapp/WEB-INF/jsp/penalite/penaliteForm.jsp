<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Penalisation</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center">Penalisation</h3>
                </div>
                <div class="card-body">
                    <form action="/penalite/creer/${idEmprunt}" method="POST">
                        <div class="mb-3">
                            <label for="sanction" class="form-label">Sanction (Nombre de jour)</label>
                            <input type="number" class="form-control" id="sanction" name="sanction" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Penaliser</button>
                            <a href="/emprunts">
                                <button type="button" class="btn btn-secondary">Annuler</button>
                            </a>
                        </div>

                        <br>
                        <c:if test="${not empty erreur}">
                            <div class="alert alert-danger text-center">${erreur}</div>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
