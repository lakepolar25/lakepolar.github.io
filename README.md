<!DOCTYPE html>
<html lang="en">
<head>
    <title>Roblox Developer Products</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            text-align: center;
            background-color: #121212;
            color: #ffffff;
            margin: 0;
            padding: 0;
        }
        .header {
            padding: 20px;
            background: #2a2a2a;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 2px solid #444;
        }
        .container {
            margin: 40px auto;
            max-width: 800px;
        }
        .button {
            display: inline-block;
            padding: 15px 30px;
            margin: 20px;
            border-radius: 10px;
            background: #ff8c42;
            color: #121212;
            font-weight: bold;
            text-decoration: none;
            transition: background 0.3s;
            cursor: pointer;
        }
        .button:hover {
            background: #ff6f20;
        }
        .footer {
            margin-top: 50px;
            padding: 20px;
            background: #2a2a2a;
            border-top: 2px solid #444;
        }
        .product-card {
            border: 1px solid #333;
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            background: #1e1e1e;
        }
        .special-thanks {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }
        .thanks-badge {
            padding: 10px 20px;
            border-radius: 20px;
            background: #ff8c42;
            color: #121212;
        }
    </style>
</head>
<body>

    <div class="header">Roblox Developer Products Viewer</div>

    <div class="container">
        <button class="button" onclick="startBypass()">Start Bypass</button>
        <div id="output"></div>
    </div>

    <div class="footer">
        <div>Created with ❤️ by Lake</div>
        <div class="special-thanks">
            <span class="thanks-badge">Fuglen</span>
            <span class="thanks-badge">LakePolar</span>
            <span class="thanks-badge">Megan01Life</span>
        </div>
    </div>

    <script>
        const proxyUrl = 'https://mskswokcev.devrahsanko.workers.dev/';
        const universeToGameIds = {
            3317771874: [6839173394, 6401952734],
            6401952734: [13451391992, 10338606269]
        };

        const randomHeaders = [
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
            'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:103.0) Gecko/20100101 Firefox/103.0'
        ];

        async function startBypass() {
            for (const universeId in universeToGameIds) {
                const gameIds = universeToGameIds[universeId];
                for (const gameId of gameIds) {
                    await fetchProducts(universeId, gameId);
                    await randomDelay();
                }
            }
        }

        async function fetchProducts(universeId, gameId) {
            const output = document.getElementById('output');
            output.innerHTML += `<p>Fetching products for Universe ${universeId} (Game ${gameId})...</p>`;

            try {
                const response = await fetch(`${proxyUrl}https://apis.roblox.com/developer-products/v1/universes/${universeId}/developerproducts?pageNumber=1&pageSize=1000`, {
                    headers: {
                        'User-Agent': randomHeaders[Math.floor(Math.random() * randomHeaders.length)],
                        'Referer': `https://www.roblox.com/games/${gameId}`
                    }
                });

                if (!response.ok) {
                    throw new Error(`Error ${response.status}`);
                }

                const data = await response.json();

                if (data.length === 0) {
                    output.innerHTML += `<p>No products found for Universe ${universeId}.</p>`;
                    return;
                }

                data.forEach(product => {
                    output.innerHTML += `
                        <div class="product-card">
                            🛒 <strong>${product.Name}</strong><br>
                            💰 Price: ${product.PriceInRobux} Robux<br>
                            🔗 ID: ${product.ProductId}<br>
                            <a class="button" href="https://www.roblox.com/library/${product.ProductId}" target="_blank">View Asset</a>
                        </div>
                    `;
                });

            } catch (error) {
                output.innerHTML += `<p>Error fetching products: ${error.message}</p>`;
            }
        }

        function randomDelay() {
            return new Promise(resolve => setTimeout(resolve, Math.random() * 3000 + 1000));
        }
    </script>

</body>
</html>
