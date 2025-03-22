<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Roblox Group Game Viewer</title>
  <style>
    body {
      background-color: #121212;
      color: white;
      font-family: Arial, sans-serif;
      text-align: center;
      padding: 20px;
    }
    h1 {
      color: #4285f4;
    }
    input, button {
      margin: 10px;
      padding: 10px;
      border: none;
      border-radius: 5px;
      font-size: 16px;
    }
    input {
      width: 200px;
    }
    button {
      background-color: #800080;
      color: white;
      cursor: pointer;
    }
    button:hover {
      background-color: #9a4a9a;
    }
    .game-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 20px;
      margin-top: 20px;
    }
    .game-card {
      background: #1e1e1e;
      border-radius: 10px;
      padding: 15px;
      width: 250px;
    }
    .game-card img {
      width: 100%;
      border-radius: 10px;
    }
    .footer {
      margin-top: 20px;
    }
  </style>
</head>
<body>
  <h1>Roblox Group Game Viewer</h1>
  <input type="text" id="groupId" placeholder="Enter Group ID">
  <button onclick="fetchGames()">Fetch Games</button>
  <p id="errorMessage"></p>

  <div class="game-container" id="gameContainer"></div>

  <div class="footer">
    <p>This site is not affiliated with Roblox Corporation. It is for viewing Roblox group games.</p>
    <button onclick="window.open('https://discord.gg/B2rqHKTJkC', '_blank')">Discord</button>
    <button onclick="window.open('https://twitter.com/AstroLeaksT', '_blank')">Twitter</button>
  </div>

  <script>
    async function fetchGames() {
      const groupId = document.getElementById('groupId').value;
      const errorMessage = document.getElementById('errorMessage');
      const gameContainer = document.getElementById('gameContainer');
      errorMessage.textContent = '';
      gameContainer.innerHTML = '';

      try {
        const response = await fetch(`https://mskswokcev.devrahsanko.workers.dev/?groupId=${groupId}`);
        const data = await response.json();

        if (!response.ok) throw new Error("Failed to fetch games");

        if (!data || data.length === 0) {
          errorMessage.textContent = 'No games found for this group.';
          return;
        }

        data.forEach(game => {
          const gameCard = document.createElement('div');
          gameCard.className = 'game-card';

          gameCard.innerHTML = `
            <img src="${game.icon || 'https://via.placeholder.com/150'}" alt="${game.name}">
            <h3>${game.name}</h3>
            <p>Visits: ${game.visits.toLocaleString()}</p>
            <p>Created: ${new Date(game.created).toDateString()}</p>
            <button onclick="window.open('https://www.roblox.com/games/${game.id}', '_blank')">Play Game</button>
          `;
          gameContainer.appendChild(gameCard);
        });
      } catch (error) {
        errorMessage.textContent = 'Error fetching games. Try again later.';
        console.error('Error:', error);
      }
    }
  </script>
</body>
</html>
