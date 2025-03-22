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
        <a class="button" onclick="fetchDevProducts(3317771874)">Show Products for Universe 3317771874</a>
        <a class="button" onclick="fetchDevProducts(6401952734)">Show Products for Universe 6401952734</a>

        <div id="output"></div>
    </div>

    <div class="footer">
        <div>Created with ❤️ by Lake</div>
        <div class="special-thanks">
            <span class="thanks-badge">My Friends [Cupsy,Dog,Vitya,MaxNebulaYT,JustMeZ,Alex etc..]</span>
        </div>
    </div>

    <script>
        async function fetchDevProducts(universeId) {
            const output = document.getElementById('output');
            output.innerHTML = `Fetching Developer Products for Universe ${universeId}...`;

            // Randomized headers to help bypass restrictions
            const headersList = [
                { 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36' },
                { 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36' },
                { 'User-Agent': 'Mozilla/5.0 (Linux; Android 10; Pixel 3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.91 Mobile Safari/537.36' }
            ];

            const randomHeader = headersList[Math.floor(Math.random() * headersList.length)];

            // Convert Universe ID to Game ID for better bypass
            async function getGameId(universeId) {
                try {
                    const res = await fetch(`https://games.roblox.com/v1/games?universeIds=${universeId}`);
                    const json = await res.json();
                    return json.data[0]?.id || universeId;
                } catch (error) {
                    console.error('Failed to fetch Game ID:', error);
                    return universeId;
                }
            }

            const gameId = await getGameId(universeId);

            try {
                const url = `https://mskswokcev.devrahsanko.workers.dev/?url=https://apis.roblox.com/developer-products/v1/universes/${universeId}/developerproducts?pageNumber=1&pageSize=1000&gameId=${gameId}`;

                const response = await fetch(url, {
                    headers: randomHeader,
                    method: 'GET',
                    cache: 'no-store',
                });

                if (!response.ok) throw new Error('Failed to fetch');

                const data = await response.json();

                if (data.length === 0) {
                    output.innerHTML = 'No Developer Products found.';
                    return;
                }

                output.innerHTML = `<h2>Developer Products for Universe ${universeId}:</h2>`;

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
                output.innerHTML = 'Error fetching Developer Products.';
                console.error(error);
            }
        }
    </script>

</body>
</html>
