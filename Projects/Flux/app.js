document.addEventListener('DOMContentLoaded', () => {

    // --- 1. Main Revenue Chart ---
    const ctx = document.getElementById('mainChart').getContext('2d');

    const gradientFill = ctx.createLinearGradient(0, 0, 0, 400);
    gradientFill.addColorStop(0, 'rgba(59, 130, 246, 0.5)');
    gradientFill.addColorStop(1, 'rgba(59, 130, 246, 0.0)');

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Revenue',
                data: [12000, 19000, 15000, 25000, 22000, 30000, 28000, 35000, 42000, 39000, 45000, 52000],
                borderColor: '#60a5fa',
                backgroundColor: gradientFill,
                borderWidth: 3,
                pointBackgroundColor: '#1e3a8a',
                pointBorderColor: '#60a5fa',
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 6,
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { beginAtZero: true, grid: { color: 'rgba(255, 255, 255, 0.05)', borderDash: [5, 5] }, ticks: { color: '#9ca3af', callback: v => '$' + v / 1000 + 'k' } },
                x: { grid: { display: false }, ticks: { color: '#9ca3af' } }
            }
        }
    });

    // --- 2. Sparklines ---
    const sparklineOptions = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false }, tooltip: { enabled: false } },
        scales: { x: { display: false }, y: { display: false } },
        elements: { point: { radius: 0 } }
    };

    new Chart(document.getElementById('incomeSparkline'), {
        type: 'line',
        data: { labels: [1, 2, 3, 4, 5, 6, 7], datasets: [{ data: [10, 12, 11, 15, 14, 18, 20], borderColor: '#4ade80', borderWidth: 2, tension: 0.3 }] },
        options: sparklineOptions
    });

    new Chart(document.getElementById('expenseSparkline'), {
        type: 'line',
        data: { labels: [1, 2, 3, 4, 5, 6, 7], datasets: [{ data: [20, 18, 22, 19, 24, 21, 15], borderColor: '#f87171', borderWidth: 2, tension: 0.3 }] },
        options: sparklineOptions
    });

    // --- 3. Dynamic Transaction List (Shared Data) ---
    const transactions = [
        { name: 'Netflix Subscription', type: 'Entertainment', date: 'Today, 10:42 AM', amount: -14.99, status: 'Success' },
        { name: 'Freelance Client', type: 'Income', date: 'Yesterday, 4:30 PM', amount: 850.00, status: 'Success' },
        { name: 'Grocery Store', type: 'Shopping', date: 'Sep 24, 1:20 PM', amount: -124.50, status: 'Success' },
        { name: 'Spotify Premium', type: 'Entertainment', date: 'Sep 22, 9:00 AM', amount: -9.99, status: 'Pending' },
        { name: 'Electric Bill', type: 'Utilities', date: 'Sep 20, 11:15 AM', amount: -85.20, status: 'Success' },
        { name: 'Apple Store', type: 'Gadgets', date: 'Sep 18, 2:10 PM', amount: -1299.00, status: 'Success' },
        { name: 'Upwork Payout', type: 'Income', date: 'Sep 15, 9:00 AM', amount: 1500.00, status: 'Success' }
    ];

    const generateTxHTML = (tx) => {
        const isNegative = tx.amount < 0;
        const colorClass = isNegative ? 'text-white' : 'text-green-400';
        const iconBg = isNegative ? 'bg-white/5' : 'bg-green-500/10';
        const iconColor = isNegative ? 'text-white' : 'text-green-400';
        const icon = isNegative ? 'ph-arrow-up-right' : 'ph-arrow-down-left';
        const statusColor = tx.status === 'Success' ? 'bg-green-500/20 text-green-300' : 'bg-yellow-500/20 text-yellow-300';

        return `
            <div class="flex items-center justify-between p-3 rounded-xl hover:bg-white/5 transition-colors cursor-pointer group">
                <div class="flex items-center gap-4">
                    <div class="w-10 h-10 rounded-full ${iconBg} flex items-center justify-center ${iconColor}">
                        <i class="ph ${icon} text-lg"></i>
                    </div>
                    <div>
                        <h4 class="font-semibold text-sm group-hover:text-blue-200 transition-colors">${tx.name}</h4>
                        <p class="text-xs text-gray-400">${tx.type} • ${tx.date}</p>
                    </div>
                </div>
                <div class="text-right">
                    <p class="font-bold text-sm ${colorClass}">${isNegative ? '' : '+'}$${Math.abs(tx.amount).toFixed(2)}</p>
                    <span class="text-[10px] px-2 py-0.5 rounded-full ${statusColor}">${tx.status}</span>
                </div>
            </div>
        `;
    };

    // Render Short List to Dashboard
    const dashboardList = document.getElementById('transaction-list-dashboard');
    if (dashboardList) dashboardList.innerHTML = transactions.slice(0, 5).map(generateTxHTML).join('');

    // Render Full List to Transactions View
    const fullList = document.getElementById('transaction-list-full');
    if (fullList) fullList.innerHTML = transactions.map(generateTxHTML).join('');


    // --- 4. Navigation Logic ---
    const navItems = document.querySelectorAll('.nav-item');
    const viewSections = document.querySelectorAll('.view-section');
    const pageTitle = document.getElementById('page-title');

    navItems.forEach(item => {
        item.addEventListener('click', (e) => {
            // 1. Prevent Default if it's a link (though we used buttons now)
            e.preventDefault();

            // 2. Remove Active State from all Nav Items
            navItems.forEach(nav => nav.classList.remove('active'));

            // 3. Add Active State to Clicked Item
            // Use currentTarget because the click might be on the icon inside the button
            const clickedItem = e.currentTarget;
            clickedItem.classList.add('active');

            // 4. Get Target View
            const targetViewId = clickedItem.getAttribute('data-view');

            // 5. Hide All Views
            viewSections.forEach(section => {
                section.classList.add('hidden');
                section.classList.remove('animate-fade-in'); // Reset animation
            });

            // 6. Show Target View
            const targetView = document.getElementById(`view-${targetViewId}`);
            if (targetView) {
                targetView.classList.remove('hidden');
                // Trigger Reflow for animation restart (optional but helps)
                void targetView.offsetWidth;
                targetView.classList.add('animate-fade-in');
            }

            // 7. Update Page Title
            if (pageTitle) {
                // Capitalize first letter
                pageTitle.textContent = targetViewId.charAt(0).toUpperCase() + targetViewId.slice(1);
            }
        });
    });


    // --- 5. Quick Transfer Logic ---
    const btnSend = document.getElementById('btn-send-transfer');
    const inputAmount = document.getElementById('transfer-amount');
    const balanceEl = document.getElementById('total-balance');
    let currentBalance = 124500.20;

    if (btnSend && inputAmount && balanceEl) {
        btnSend.addEventListener('click', () => {
            const amount = parseFloat(inputAmount.value);

            if (amount && amount > 0) {
                // 1. Update Balance
                currentBalance -= amount;
                balanceEl.textContent = '$' + currentBalance.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });

                // 2. Add New Transaction
                const newTx = {
                    name: 'Quick Transfer',
                    type: 'Transfer',
                    date: 'Just Now',
                    amount: -amount,
                    status: 'Success'
                };
                transactions.unshift(newTx);

                // 3. Re-render Lists
                renderTransactions();

                // 4. Reset Input & Animation Feedback
                inputAmount.value = '';
                btnSend.innerHTML = '<i class="ph ph-check text-xl"></i> Sent!';
                setTimeout(() => {
                    btnSend.innerText = 'Send';
                }, 2000);
            }
        });
    }

    // Helper to render transactions (Refactored)
    function renderTransactions() {
        const dashboardList = document.getElementById('transaction-list-dashboard');
        const fullList = document.getElementById('transaction-list-full');

        if (dashboardList) dashboardList.innerHTML = transactions.slice(0, 5).map(generateTxHTML).join('');
        if (fullList) fullList.innerHTML = transactions.map(generateTxHTML).join('');
    }


    // --- 6. Interactive Charts (Time Period) ---
    const chartSelect = document.querySelector('select'); // Assuming only one select for now in Main Chart section

    // Mock Data for different periods
    const chartData = {
        'Weekly': { labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'], data: [5000, 7000, 4500, 8000, 6000, 9000, 7500] },
        'Monthly': { labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'], data: [12000, 19000, 15000, 25000, 22000, 30000, 28000, 35000, 42000, 39000, 45000, 52000] },
        'Yearly': { labels: ['2019', '2020', '2021', '2022', '2023', '2024'], data: [150000, 200000, 180000, 250000, 300000, 350000] }
    };

    if (chartSelect) {
        chartSelect.addEventListener('change', (e) => {
            const period = e.target.value;
            const newData = chartData[period] || chartData['Monthly'];

            // Update Chart
            // Note: We need access to 'mainChart' variable. 
            // In a cleaner app, we'd declare mainChart continuously. 
            // For now, let's assume valid scope or re-declarations if needed, but 'mainChart' variable isn't globally exposed above.
            // Let's rely on Chart.js registry or modify the variable scope above. 

            // To fix scope, we should have captured the chart instance variable 'mainChart' earlier. 
            // For this code block, I will access the instance from the Chart registry since we didn't export it.
            const chartInstance = Chart.getChart("mainChart");
            if (chartInstance) {
                chartInstance.data.labels = newData.labels;
                chartInstance.data.datasets[0].data = newData.data;
                chartInstance.update();
            }
            // --- 7. Wallet Card Flip ---
            const cardContainer = document.querySelector('.card-flip-container');
            if (cardContainer) {
                cardContainer.addEventListener('click', () => {
                    const inner = cardContainer.querySelector('.card-inner');
                    inner.classList.toggle('flipped');
                });
            }

        });
    }


});
