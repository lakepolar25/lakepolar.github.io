<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Roblox Group Game Viewer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: white;
            text-align: center;
            padding: 20px;
        }

        h1 {
            color: #3b82f6;
        }

        input {
            padding: 10px;
            border-radius: 5px;
            border: none;
            margin-right: 10px;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #6b21a8;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #8b5cf6;
        }

        .footer {
            margin-top: 20px;
        }

        .social-button {
            margin: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #6b21a8;
            color: white;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }

        .game-card {
            border: 1px solid #6b21a8;
            border-radius: 10px;
            padding: 15px;
            margin: 10px auto;
            max-width: 500px;
            background-color: #1e1e1e;
        }
    </style>
</head>

<body>
    <h1><a href="https://lakepolar.github.io" style="color: #3b82f6; text-decoration: none;">lakepolar.github.io</a></h1>

    <h2>Roblox Group Game Viewer</h2>

    <input type="text" id="groupId" placeholder="Enter Group ID" value="3959677">
    <button onclick="fetchGames()">Fetch Games</button>

    <p id="status">Enter a group ID and click 'Fetch Games'.</p>

    <div id="gameList"></div>

    <p class="footer">This site is not made or affiliated with Roblox Corporation. It is for viewing Roblox group games.</p>

    <a href="#" class="social-button">🎮 Discord</a>
    <a href="#" class="social-button">🐦 Twitter</a>

    <script>
        async function fetchGames() {
            const groupId = document.getElementById("groupId").value;
            const status = document.getElementById("status");
            const gameList = document.getElementById("gameList");

            status.textContent = "Fetching games...";
            gameList.innerHTML = "";

            try {
                const response = await fetch(`https://your-cloudflare-worker-url.workers.dev/?groupId=${groupId}`);
                if (!response.ok) throw new Error("Failed to fetch games.");

                const games = await response.json();

                if (!games.length) {
                    status.textContent = "No games found for this group.";
                    return;
                }

                status.textContent = "Games fetched successfully.";

                games.forEach(game => {
                    const card = document.createElement("div");
                    card.className = "game-card";
                    card.innerHTML = `
                        <h3>${game.name}</h3>
                        <a href="https://www.roblox.com/games/${game.placeId}" target="_blank">Play Game</a>
                    `;
                    gameList.appendChild(card);
                });
            } catch (error) {
                status.textContent = "Error fetching games. Try again later.";
            }
        }
    </script>
</body>

</html>
