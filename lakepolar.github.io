<!DOCTYPE html>
<html lang="en">
<head>
    <title>Roblox Game Developer Products</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            text-align: center; 
            margin-top: 50px; 
            background-color: #121212; 
            color: #ffffff;
        }
        button { 
            padding: 10px 20px; 
            cursor: pointer; 
            background-color: #333; 
            color: #ffffff; 
            border: none; 
            border-radius: 5px;
            margin: 10px;
        }
        button:hover {
            background-color: #555;
        }
        #output { margin-top: 20px; }
        a.button-link {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            background-color: #1e1e1e;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
        }
        a.button-link:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
    <h1>Roblox Game Developer Products</h1>

    <button onclick="fetchDevProducts(3317771874)">Show Products for 3317771874</button>
    <button onclick="fetchDevProducts(6401952734)">Show Products for 6401952734</button>

    <div id="output"></div>

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
                        <p>
                            🛒 <strong>${product.Name}</strong><br>
                            💰 Price: ${product.PriceInRobux} Robux<br>
                            🔗 ID: ${product.ProductId}<br>
                            <a class="button-link" href="https://www.roblox.com/library/${product.ProductId}" target="_blank">View Asset</a>
                        </p>
                        <hr>
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
