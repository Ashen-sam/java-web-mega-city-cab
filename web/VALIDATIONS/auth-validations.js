document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('authForm');
    const usernameInput = document.getElementById('username');
    const passwordInput = document.getElementById('password');
    const usernameError = document.getElementById('usernameError');
    const passwordError = document.getElementById('passwordError');

    usernameInput.addEventListener('input', () => {
        usernameError.textContent = '';
    });

    passwordInput.addEventListener('input', () => {
        passwordError.textContent = '';
    });

   

    form.addEventListener('submit', (event) => {
        let isValid = true;

        if (!usernameInput.value.trim()) {
            usernameError.textContent = 'Username is required';
            isValid = false;
        }

        if (!passwordInput.value.trim()) {
            passwordError.textContent = 'Password is required';
            isValid = false;
        }

        if (!isValid) {
            event.preventDefault();
        }
    });
});

 window.onload = function() {
            document.getElementById("authForm").reset();
        };