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
      font-size: 2em;
    }
    input {
      padding: 10px;
      border-radius: 5px;
      border: none;
      margin: 10px;
    }
    button {
      padding: 10px 20px;
      margin: 10px;
      border: none;
      border-radius: 5px;
      background-color: #8a2be2; /* Purple */
      color: white;
      cursor: pointer;
      font-weight: bold;
    }
    button:hover {
      background-color: #6a1bbd;
    }
    .game-card {
      border: 1px solid #444;
      border-radius: 8px;
      margin: 10px;
      padding: 15px;
      display: inline-block;
      width: 250px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }
    .footer {
      margin-top: 20px;
      font-size: 0.9em;
      opacity: 0.8;
    }
  </style>
</head>
<body>
  <h1>Roblox Group Game Viewer</h1>

  <input type="text" id="groupId" placeholder="Enter Roblox Group ID" />
  <button onclick="fetchGames()">View Games</button>

  <div id="gameContainer"></div>

  <div class="footer">
    <p>This site is not made or affiliated with Roblox Corporation.<br> This site is made to view games from a Roblox group.</p>
    <a href="#" style="text-decoration: none; color: white;">
      <button>Discord</button>
    </a>
    <a href="#" style="text-decoration: none; color: white;">
      <button>Twitter</button>
    </a>
  </div>

  <script>
    async function fetchGames() {
      const groupId = document.getElementById('groupId').value;
      if (!groupId) {
        alert('Please enter a Roblox Group ID.');
        return;
      }

      const workerUrl = 'https://https://mskswokcev.devrahsanko.workers.dev/?groupId=' + groupId;

      try {
        const response = await fetch(workerUrl);
        const data = await response.json();

        const gameContainer = document.getElementById('gameContainer');
        gameContainer.innerHTML = '';

        if (data.data && data.data.length > 0) {
          data.data.forEach(game => {
            const gameCard = document.createElement('div');
            gameCard.className = 'game-card';
            gameCard.innerHTML = `
              <h3>${game.name}</h3>
              <img src="${game.thumbnailUrl || 'https://via.placeholder.com/150'}" alt="Game Thumbnail" width="200">
              <p>Players: ${game.playing}</p>
              <a href="https://www.roblox.com/games/${game.rootPlaceId}" target="_blank">
                <button>Play Game</button>
              </a>
            `;
            gameContainer.appendChild(gameCard);
          });
        } else {
          gameContainer.innerHTML = '<p>No games found for this group.</p>';
        }
      } catch (error) {
        console.error('Error fetching games:', error);
        document.getElementById('gameContainer').innerHTML = '<p>Error fetching games. Check the group ID and try again.</p>';
      }
    }
  </script>
</body>
</html>
