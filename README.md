<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Developer Products Viewer</title>
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #151425;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            padding: 20px;
            box-sizing: border-box;
        }

        .product-card {
            background: #1c1b2f;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-name {
            font-size: 1.5rem;
            color: #ff79c6;
        }

        .product-price {
            font-size: 1.2rem;
            color: #8be9fd;
        }

        .product-creator {
            font-size: 1rem;
            color: #bd93f9;
        }

        .product-date {
            font-size: 0.9rem;
            color: #6272a4;
        }
    </style>
</head>
<body>
    <div class="container" id="product-container"></div>

    <script>
        async function fetchDeveloperProducts() {
            try {
                const response = await fetch('https://mskswokcev.devrahsanko.workers.dev');
                const data = await response.json();

                const container = document.getElementById('product-container');

                data.forEach(product => {
                    const card = document.createElement('div');
                    card.className = 'product-card';

                    card.innerHTML = `
                        <div class="product-name">${product.name}</div>
                        <div class="product-price">${product.priceInRobux || 0} Robux</div>
                        <div class="product-creator">By: ${product.creator || 'Unknown'}</div>
                        <div class="product-date">Created: ${new Date(product.created).toLocaleDateString()}</div>
                    `;

                    container.appendChild(card);
                });
            } catch (error) {
                console.error('Error fetching developer products:', error);
            }
        }

        fetchDeveloperProducts();
    </script>
</body>
</html>
