function submitFormAndNotify(formId, urlServlet) {
    $(formId).submit(function (event) {
        event.preventDefault();

        $.ajax({
            type: 'POST',
            url: urlServlet,
            data: $(this).serialize(),
            success: function (response) {
                normalNotify(response);
                $(formId)[0].reset();
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
            console.log(response);
            notifyAndRedirect(response.type, response.message, response.namePage, response.pageUrl);
            },
            error: function (xhr, status, error) {
                var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
                errorNotify(errorMessage);
            }
        });
}

function callServletAndRedirect(servletUrl, pageUrl) {
    $.ajax({
        type: 'GET',
        url: servletUrl,
        success: function (response) {
            console.log(response)
            if (response.type === 'success') {
                window.location.href = pageUrl;
            } else if (response.type === 'error') {
                notifyAndRedirect(response.type, response.message, response.namePage, response.pageUrl);
            } else {
                notifyAndRedirect(response.type, response.message, response.namePage, response.pageUrl);
            }
        },
        error: function (xhr, status, error) {
            var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
            errorNotify(errorMessage);


        }
    });
}

function callServlet(servletUrl, dataSending) {
    $.ajax({
        type: 'POST',
        url: servletUrl,
        data: {[dataSending.name]: dataSending.dataValue},
        success: function (response) {
            Toast.fire({
                icon: "success",
                title: response,
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
            notifyRedirect(data.message, data.namePage, data.pageUrl);
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
