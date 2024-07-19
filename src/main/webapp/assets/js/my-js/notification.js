function showNotification(message, isError = false) {
    var notification = document.getElementById('notification');
    notification.innerText = message;
    notification.className = isError ? 'error' : '';
    notification.style.display = 'block';
    setTimeout(function() {
        notification.style.display = 'none';
    }, 3000);
}