document.addEventListener('DOMContentLoaded', () => {
    const deathScreen = document.getElementById('death-screen');
    
    window.addEventListener('message', (event) => {
        const data = event.data;
        
        if (data.action === 'showDeathScreen') {
            deathScreen.style.display = 'flex';
            document.getElementById('timer').textContent = data.timeLeft;
        } else if (data.action === 'hideDeathScreen') {
            deathScreen.style.display = 'none';
        } else if (data.action === 'updateTimer') {
            document.getElementById('timer').textContent = data.timeLeft;
        }
    });
});