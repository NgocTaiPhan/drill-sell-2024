const modal = document.querySelector('#myModal');
const btnOpenModal = document.querySelector('.open-modal');
const btnCloseModal = document.querySelector('.close-btn');

// Mở modal
function openModal() {
    modal.style.display = "block"
}

// Đóng modal
function closeModal() {
    modal.style.display = "none";
}

// Mở/Đóng modal khi nhấn nút
btnOpenModal.addEventListener('click', openModal);
btnCloseModal.addEventListener('click', closeModal);
//Nếu click bên ngoài modal thì modal sẽ đóng
window.addEventListener('click', (event) => {
    if (event.target === modal) {
        closeModal();
    }
})
