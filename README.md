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
        <button class="button" onclick="fetchDevProducts(3317771874)">Universe 3317771874</button>
        <button class="button" onclick="fetchDevProducts(6401952734)">Universe 6401952734</button>

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
        async function fetchDevProducts(universeId) {
            const output = document.getElementById('output');
            output.innerHTML = `Fetching Developer Products for Universe ${universeId}...`;

            try {
                const url = `https://mskswokcev.devrahsanko.workers.dev/?universeId=${universeId}`;
                const data = await bypass401(url);

                if (!data || data.length === 0) {
                    output.innerHTML = "No Developer Products found.";
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
                output.innerHTML = "Error fetching Developer Products.";
                console.error(error);
            }
        }

        async function bypass401(url) {
            let retries = 3;

            while (retries > 0) {
                try {
                    const headers = new Headers({
                        'User-Agent': getRandomUserAgent(),
                        'Cache-Control': 'no-cache',
                        'Pragma': 'no-cache'
                    });
                    const response = await fetch(url, { headers });

                    if (response.status === 401) {
                        console.warn("401 detected, retrying...");
                        retries--;
                        await new Promise(res => setTimeout(res, 1500));
                        continue;
                    }

                    if (!response.ok) throw new Error("Failed to fetch");
                    return await response.json();
                } catch (e) {
                    console.error("Bypass error:", e);
                }
            }

            throw new Error("Bypass failed after multiple retries.");
        }

        function getRandomUserAgent() {
            const userAgents = [
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
                "Mozilla/5.0 (iPhone; CPU iPhone OS 15_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Mobile/15E148 Safari/604.1"
            ];
            return userAgents[Math.floor(Math.random() * userAgents.length)];
        }
    </script>

</body>
</html>
