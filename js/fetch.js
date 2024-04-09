// Specify the API endpoint for user data
const apiUrl = 'https://cat-fact.herokuapp.com/facts';

// Make a GET request using the Fetch API
fetch(apiUrl)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        // Process the retrieved user data
        console.log('Data:', data);
    })
    .catch(error => {
        console.error('Error:', error);
    });