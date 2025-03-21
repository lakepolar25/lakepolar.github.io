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
            <span class="thanks-badge">My Friends</span>
        </div>
    </div>

    <script>
        async function fetchDevProducts(universeId) {
            const output = document.getElementById('output');

            output.innerHTML = `Fetching Developer Products for Universe ${universeId}...`;

            try {
                const response = await fetch(`https://apis.roblox.com/developer-products/v1/universes/${universeId}/developerproducts?pageNumber=1&pageSize=1000`);
                if (!response.ok) throw new Error("Failed to fetch");

                const data = await response.json();

                if (data.length === 0) {
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
    </script>

</body>
</html>
