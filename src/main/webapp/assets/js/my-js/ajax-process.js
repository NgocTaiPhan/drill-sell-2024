function submitFormAndNotify(formId, urlServlet) {
    $(document).on('submit', formId, function (event) {
        event.preventDefault();
        var $form = $(this);
        $.ajax({
            type: 'POST',
            url: urlServlet,
            data: $form.serialize(),
            success: function (response) {
                normalNotify(response.type, response.message);
            },
            error: function (xhr, status, error) {
                var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
                errorNotify(errorMessage);
            }
        });
    });
}


function submitFormAndRedirect(event, form, urlServlet) {
    event.preventDefault();

    $.ajax({
        type: 'POST',
        url: urlServlet,
        data: $(form).serialize(),
        success: function (response) {
            notifyAndRedirect(response.type, response.message, response.namePage, response.pageUrl);
            },
            error: function (xhr, status, error) {
                var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
                errorNotify(errorMessage);
            }
        });
}


function callServletTo(servletUrl, dataSending) {
    $.ajax({
        type: 'POST',
        url: servletUrl,
        data: {[dataSending.name]: dataSending.dataValue},
        success: function (response) {
            Toast.fire({
                icon: response.type,
                title: response.message,
            });
        },
        error: function (xhr, status, error) {
            var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
            var data;
            try {
                data = JSON.parse(xhr.responseText);
            } catch (e) {
                data = {
                    message: errorMessage,
                    namePage: "OK",
                    pageUrl: "home.jsp"
                };
            }
        }
    });
}

// callServlet.js

function callServlet(servletUrl, dataSending, reloadTable, onError) {
    var dataObject = {};
    dataSending.forEach(function (item) {
        dataObject[item.name] = item.dataValue;
    });

    $.ajax({
        type: 'POST',
        url: servletUrl,
        data: dataObject,
        success: function (response) {
            if (typeof reloadTable === 'function') {
                reloadTable(response);
            }
        },
        error: function (xhr, status, error) {
            if (typeof onError === 'function') {
                onError(xhr, status, error);
            }
        }
    });
}
