function submitFormAndNotify(formId, urlServlet) {
    $(formId).submit(function (event) {
        event.preventDefault();

        $.ajax({
            type: 'POST',
            url: urlServlet,
            data: $(this).serialize(),
            success: function (response) {
                successNotify(response);
                $(formId)[0].reset();
            },
            error: function (xhr, status, error) {
                var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
                errorNotify(errorMessage);
            }
        });
    });
}

function submitFormAndRedirect(formId, urlServlet) {
    $(formId).submit(function (event) {
        event.preventDefault();

        $.ajax({
            type: 'POST',
            url: urlServlet,
            data: $(this).serialize(),
            success: function (response) {
                var data = JSON.parse(response);
                successNotifyAndRedirect(data.message, data.namePage, data.pageUrl);
            },
            error: function (xhr, status, error) {
                var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
                errorNotify(errorMessage);
            }
        });
    });
}

function callServletAndRedirect(servletUrl, pageUrl) {
    $.ajax({
        type: 'GET',
        url: servletUrl,
        success: function () {
            window.location.href = pageUrl;
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
