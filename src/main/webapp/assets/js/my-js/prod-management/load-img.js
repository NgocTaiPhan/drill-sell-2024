
function openCKFinder() {
    CKFinder.popup({
        chooseFiles: true,
        onInit: function (finder) {
            finder.on('files:choose', function (evt) {
                var file = evt.data.files.first();
                var imageUrlInput = document.getElementById('imageUrlInput');
                var loadProdsImg = document.getElementById('loadProdsImg');

                imageUrlInput.value = file.getUrl();
                loadProdsImg.src = file.getUrl();
            });
        }
    });
}

const imageUrlInput = document.querySelector('.imageUrlInput');
const loadProdsImg = document.querySelector('.loadProdsImg');


//Load image
imageUrlInput.addEventListener('input', function () {
    const imageUrl = this.value.trim();
    if (imageUrl !== '') {
        loadProdsImg.src = imageUrl;
    } else {
        loadProdsImg.src = '';
    }
});
