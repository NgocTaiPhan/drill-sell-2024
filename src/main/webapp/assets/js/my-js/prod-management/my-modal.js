function handleModal(modalId) {
    const modal = document.getElementById(modalId);
    const btnOpen = document.querySelector(`[link-to-modal='${modalId}']`);
    const btnClose = document.querySelector('.close-btn');
    console.log(modal);

    function openModal() {
        modal.style.display = 'block';
        modal.style.position = 'fixed';
        modal.style.top = '50%';
        modal.style.left = '50%';
        modal.style.transform = 'translate(-50%, -50%)';
    }

    function closeModal() {
        modal.style.display = 'none';
    }

    btnOpen.addEventListener('click', openModal);
    btnClose.addEventListener('click', closeModal);
    window.addEventListener('click', (event) => {
        if (event.target === modal)
            closeModal();
    });
}

handleModal('myModal');
handleModal('modalDetailProd');