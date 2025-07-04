<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Créer un emprunt</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h2>Créer un nouvel emprunt</h2>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger">${param.error}</div>
    </c:if>

    <form id="empruntForm" method="post" action="/emprunts/creer">
        <div class="form-group">
            <label for="utilisateur">Utilisateur</label>
            <select class="form-control" id="utilisateur" name="utilisateurId" required>
                <option value="">Sélectionner un utilisateur</option>
                <c:forEach items="${utilisateurs}" var="utilisateur">
                    <option value="${utilisateur.id}">
                            ${utilisateur.prenom} ${utilisateur.nom} (${utilisateur.email})
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="typeEmprunt">Type d'emprunt</label>
            <select class="form-control" id="typeEmprunt" name="typeEmpruntId" required>
                <option value="">Sélectionner un type</option>
                <c:forEach items="${typesEmprunt}" var="type">
                    <option value="${type.id}">${type.nom}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="dateDebut">Date de début</label>
            <input id="dateDebut" type="date" name="dateDebut" class="form-control"
                   value="<%= java.time.LocalDate.now() %>"
                   required>
        </div>

        <div class="form-group" id="dateFinGroup">
            <label for="dateFin">Date de fin</label>
            <input id="dateFin" type="date" name="dateFin" class="form-control"
                   value="<%= java.time.LocalDate.now().plusWeeks(2) %>"
                   required>
        </div>

        <div class="form-group">
            <label for="livre">Livre</label>
            <select class="form-control" id="livre" name="livreId" disabled required>
                <option value="">Sélectionnez d'abord un utilisateur et une date</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Créer l'emprunt</button>
    </form>
</div>

<script>
    $(document).ready(function() {
        // Gestion du type d'emprunt
        $('#typeEmprunt').change(function() {
            if ($(this).val() == 1) { // Si "Sur place" (ID=1)
                $('#dateFin').val($('#dateDebut').val());
                $('#dateFinGroup').hide();
            } else {
                $('#dateFinGroup').show();
            }
        });

        // Chargement des livres disponibles
        $('#utilisateur, #dateDebut').change(function() {
            const userId = $('#utilisateur').val();
            const dateDebut = $('#dateDebut').val();

            if (userId && dateDebut) {
                $.get('/emprunts/livres-disponibles', {
                    idUtilisateur: userId,
                    dateDebut: dateDebut,
                    dateFin: $('#dateFin').val() || dateDebut
                }, function(livres) {
                    const $livreSelect = $('#livre');
                    $livreSelect.empty().append(
                        $('<option>').val('').text('Sélectionnez un livre')
                    );

                    livres.forEach(function(livre) {
                        $livreSelect.append(
                            $('<option>').val(livre.livreId).text(
                                livre.titre + ' (Disponible: ' + livre.disponible + ')'
                            )
                        );
                    });

                    $livreSelect.prop('disabled', false);
                });
            }
        });

        // Initialisation de la date de début à aujourd'hui
        const today = new Date().toISOString().split('T')[0];
        $('#dateDebut').val(today);
    });
</script>
</body>
</html>