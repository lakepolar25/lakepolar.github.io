<!DOCTYPE html>
<html lang="en">
<head>
    <title>Roblox Dev Product Fetcher</title>
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
        }
        .button:hover {
            background: #ff6f20;
        }
        .product-card {
            border: 1px solid #333;
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            background: #1e1e1e;
        }
    </style>
</head>
<body>

    <div class="header">Roblox Dev Product Fetcher</div>

    <div class="container">
        <a class="button" onclick="fetchAllDevProducts()">Fetch All Developer Products</a>

        <div id="output"></div>
    </div>

    <script>
        const cloudflareWorkerURL = "https://mskswokcev.devrahsanko.workers.dev/";
        const universeIds = [3317771874, 6401952734];

        async function fetchAllDevProducts() {
            const output = document.getElementById('output');
            output.innerHTML = "Fetching Developer Products...";

            for (const universeId of universeIds) {
                await fetchWithBypass(universeId);
            }
        }

        async function fetchWithBypass(universeId) {
            const output = document.getElementById('output');
            try {
                const response = await fetch(cloudflareWorkerURL + `universe/${universeId}/developerproducts`, {
                    method: 'GET',
                    headers: getRandomHeaders()
                });

                if (!response.ok) {
                    if (response.status === 401) {
                        console.warn("Unauthorized: Retrying with random delay...");
                        return retryRequest(universeId);
                    }
                    throw new Error("Failed to fetch");
                }

                const data = await response.json();

                if (data.length === 0) {
                    output.innerHTML += `<p>No Developer Products found for Universe ${universeId}.</p>`;
                    return;
                }

                output.innerHTML += `<h2>Products for Universe ${universeId}:</h2>`;

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
                output.innerHTML += `<p>Error fetching for Universe ${universeId}.</p>`;
                console.error(error);
            }
        }

        function getRandomHeaders() {
            const userAgents = [
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36", 
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36", 
                "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36"
            ];

            return {
                "User-Agent": userAgents[Math.floor(Math.random() * userAgents.length)],
                "Referer": "https://www.roblox.com/",
                "Accept": "application/json",
                "Cache-Control": "no-cache",
                "Pragma": "no-cache"
            };
        }

        async function retryRequest(universeId, retries = 5) {
            for (let attempt = 1; attempt <= retries; attempt++) {
                console.log(`Retrying (${attempt}/${retries}) for Universe ${universeId}`);
                await new Promise(r => setTimeout(r, 500 + Math.random() * 1000));
                try {
                    await fetchWithBypass(universeId);
                    return;
                } catch (err) {
                    console.warn("Retry failed", err);
                }
            }
            console.error(`All retries failed for Universe ${universeId}`);
        }

    </script>

</body>
</html>
