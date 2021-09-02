function saveUser() {

    var form = document.forms.userEditor;

    if (!form.checkValidity()) {

        form.classList.add('was-validated')

        return;

    }
    var formData = new FormData(form);

    var object = {};
    formData.forEach(function(value, key) {
        object[key] = value;
    });
    var jsonFormData = JSON.stringify(object);

    var saveUserURL = "/echo/json/";

    // ветвление, если id заполнен то делаем перезапись объекта, если не заполнен то создаем новый

    if (object.id !== undefined) {

        saveUserURL = '/echo/json/';

    }

    // для теста подменяем переменную полученных полей из формы

    var jsonFormData = {
        json: JSON.stringify(window.jsonData)
    };

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: saveUserURL,
        data: jsonFormData,
        success: function(data) {

            if (data.success) {
                alert("Пользователь записан");
                updateUsersTable();
                bootstrap.Modal.getInstance(editDialogModal).hide();
            } else {
                alert("Произошла ошибка")
            }
        },
        error: function(data) {
            alert("Произошла ошибка")
        }
    });

}

function UserData(userId) {


    // Данные для заглушки
    var users = window.jsonData.users;

    var userJson = users.find(function(element) {

        if (element.id === userId) {
            return true
        }
    })

    userJson.success = true;


    userJson = {
        json: JSON.stringify(userJson)
    };

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: '/echo/json/',
        data: userJson,
        success: function(data) {

            if (data.success) {

                window.editUser = data;

                //console.log(data);

                var dialog = new bootstrap.Modal(editDialogModal);
                dialog.show();

            } else {
                alert("Произошла ошибка обработки данных")
            }
        },
        error: function(data) {
            alert("Произошла ошибка отправки запроса")
        }
    });

}

function setDeleteUser(userId) {

    window.deletedUser = userId;

}

function setEditedUser(userId) {
    UserData(userId);

}

function deleteUser() {

    var deletedUser = window.deletedUser;

    var mockData = {
        json: JSON.stringify(window.jsonData)
    };

    var deletionURL = '/echo/json/';

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: deletionURL,
        data: mockData,
        success: function(data) {

            if (data.success) {

                updateUsersTable();

                alert("Пользователь удален");

                bootstrap.Modal.getInstance(deleteDialogModal).hide();

            } else {
                alert("Произошла ошибка обработки данных")
            }
        },
        error: function(data) {
            alert("Произошла ошибка отправки запроса")
        }
    });

    window.deletedUser = undefined;

}

function setUserRoles() {

    var mockData = {
        json: JSON.stringify(window.jsonData)
    };

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: '/echo/json/',
        data: mockData,
        success: function(data) {

            if (data.success) {

                data.userRoles.forEach(function(userRoleOption) {

                    var option = new Option(userRoleOption.name, userRoleOption.id);

                    userRoleSelect.append(option);

                });

            } else {
                alert("Произошла ошибка")
            }
        },
        error: function(data) {
            alert("Произошла ошибка 1")
        }
    });

}

function updateUsersTable() {

    var mockData = {
        json: JSON.stringify(window.jsonData)
    };

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: '/echo/json/',
        data: mockData,
        success: function(data) {

            if (data.success) {

                setUsersTableBody(data.users);

            } else {
                alert("Произошла ошибка обработки данных")
            }
        },
        error: function(data) {
            alert("Произошла ошибка отправки запроса")
        }
    });

}

function setUsersTableBody(users) {

    usersBody.innerHTML = "";

    users.forEach(function(user, i) {
        var tr = document.createElement("tr");
        var thScope = document.createElement("th");
        var tdName = document.createElement("td");
        var tdEdit = document.createElement("td");
        var tdDelete = document.createElement("td");

        thScope.setAttribute("scope", "row");
        thScope.innerText = i + 1;

        tdName.innerText = user.userFirstName + " " + user.userLastName;

        tdEdit.innerHTML = `<button type="button" class="btn btn-success btn-sm" onclick = setEditedUser("` + user.id + `")>Изменить</button>`;
        tdDelete.innerHTML = `<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteDialogModal" onclick = setDeleteUser("` + user.id + `")>Удалить</button>`;

        tr.append(thScope);
        tr.append(tdName);
        tr.append(tdEdit);
        tr.append(tdDelete);

        usersBody.append(tr);
    });


}

function pageLoaded() {

    setUserRoles();
    var form = document.forms.userEditor;

    form.addEventListener('saveUser', function(event) {

        event.preventDefault()
        event.stopPropagation()

        if (form.checkValidity()) {
            saveUser()
        }

        form.classList.add('was-validated')

    }, false)

    updateUsersTable();

    editDialogModal.addEventListener('show.bs.modal', function(event) {

        if (window.editUser !== undefined) {

            userFirstName.value = window.editUser.userFirstName;
            userLastName.value = window.editUser.userLastName;
            userRoleSelect.value = window.editUser.userRole;
            userId.value = window.editUser.id

        }

    })

    editDialogModal.addEventListener('hide.bs.modal', function(event) {

        userEditor.reset();
        window.editUser = undefined;

    });

}

var deletedUser;

var editUser;

var jsonData = {
    "success": true,
    "users": [{
            "id": "0",
            "userFirstName": "Анатолий",
            "userLastName": "Вассерман",
            "userRole": "0"
        },
        {
            "id": "1",
            "userFirstName": "Дмитрий",
            "userLastName": "Белокаменцев",
            "userRole": "1"
        },
        {
            "id": "2",
            "userFirstName": "Эльдар",
            "userLastName": "Мингалиев",
            "userRole": "2"
        }
    ],
    "userRoles": [{
            "id": "0",
            "name": "Тестировщик"
        },
        {
            "id": "1",
            "name": "Программист"
        },
        {
            "id": "2",
            "name": "Менеджер"
        }
    ]
};

window.onload = pageLoaded(jsonData)