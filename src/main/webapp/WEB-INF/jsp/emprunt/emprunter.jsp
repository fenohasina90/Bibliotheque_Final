<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Emprunter un livre</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Emprunter un livre</h2>

    <c:if test="${not empty param.success}">
        <div class="alert alert-success">${param.success}</div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger">${param.error}</div>
    </c:if>

    <div class="row">
        <c:forEach items="${livres}" var="livre">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="/images/${livre.image}" class="card-img-top" alt="${livre.titre}">
                    <div class="card-body">
                        <h5 class="card-title">${livre.titre}</h5>
                        <p class="card-text">
                            Disponibles: ${livre.disponible}/${livre.exemplaire}
                        </p>
                        <button class="btn btn-primary" data-toggle="modal"
                                data-target="#empruntModal${livre.livreId}">
                            Emprunter
                        </button>
                    </div>
                </div>
            </div>

            <!-- Modal pour emprunt -->
            <div class="modal fade" id="empruntModal${livre.livreId}" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Emprunter ${livre.titre}</h5>
                            <button type="button" class="close" data-dismiss="modal">
                                <span>&times;</span>
                            </button>
                        </div>
                        <form action="/emprunts/emprunter" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="livreId" value="${livre.livreId}">
                                <div class="form-group">
                                    <label>Date de début</label>
                                    <input type="date" name="dateDebut" class="form-control"
                                           value="<fmt:formatDate value='<%= java.time.LocalDate.now() %>' pattern='yyyy-MM-dd' />"
                                           required>
                                </div>
                                <div class="form-group">
                                    <label>Date de fin</label>
                                    <input type="date" name="dateFin" class="form-control"
                                           value="<fmt:formatDate value='<%= java.time.LocalDate.now().plusWeeks(2) %>' pattern='yyyy-MM-dd' />"
                                           required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                                <button type="submit" class="btn btn-primary">Confirmer</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>