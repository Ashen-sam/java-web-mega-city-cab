// Define distance and pricing data
const locationDistances = {
    // Define distances between key locations (in km)
    'colombo fort': {
        'colombo 7': 3.5,
        'colombo 5': 5.2,
        'colombo 3': 6.8,
        'colombo 8': 4.7,
        'colombo 10': 7.1,
        'colombo 12': 8.5,
        'colombo 13': 6.9
    },
    'colombo 3': {
        'colombo fort': 6.8,
        'colombo 7': 3.2,
        'colombo 5': 2.5,
        'colombo 8': 5.1,
        'colombo 10': 4.3,
        'colombo 12': 5.6,
        'colombo 13': 4.8
    },
    'colombo 5': {
        'colombo fort': 5.2,
        'colombo 7': 2.1,
        'colombo 3': 2.5,
        'colombo 8': 3.6,
        'colombo 10': 2.8,
        'colombo 12': 4.7,
        'colombo 13': 3.9
    },
    'colombo 7': {
        'colombo fort': 3.5,
        'colombo 3': 3.2,
        'colombo 5': 2.1,
        'colombo 8': 2.9,
        'colombo 10': 4.1,
        'colombo 12': 6.2,
        'colombo 13': 5.3
    },
    'colombo 8': {
        'colombo fort': 4.7,
        'colombo 3': 5.1,
        'colombo 5': 3.6,
        'colombo 7': 2.9,
        'colombo 10': 2.4,
        'colombo 12': 4.5,
        'colombo 13': 3.2
    },
    'colombo 10': {
        'colombo fort': 7.1,
        'colombo 3': 4.3,
        'colombo 5': 2.8,
        'colombo 7': 4.1,
        'colombo 8': 2.4,
        'colombo 12': 3.1,
        'colombo 13': 2.7
    },
    'colombo 12': {
        'colombo fort': 8.5,
        'colombo 3': 5.6,
        'colombo 5': 4.7,
        'colombo 7': 6.2,
        'colombo 8': 4.5,
        'colombo 10': 3.1,
        'colombo 13': 2.3
    },
    'colombo 13': {
        'colombo fort': 6.9,
        'colombo 3': 4.8,
        'colombo 5': 3.9,
        'colombo 7': 5.3,
        'colombo 8': 3.2,
        'colombo 10': 2.7,
        'colombo 12': 2.3
    }
};

// Pricing per kilometer by vehicle type
const pricePerKm = {
    'bike': 50,         // 50 Rupees per km
    'threewheeler': 80, // 80 Rupees per km
    'van': 120          // 120 Rupees per km
};

// Base fare by vehicle type
const baseFare = {
    'bike': 100,        // 100 Rupees base fare
    'threewheeler': 150,// 150 Rupees base fare
    'van': 300          // 300 Rupees base fare
};

// Function to calculate distance between two locations
function calculateDistance(pickup, drop) {
    pickup = pickup.toLowerCase().trim();
    drop = drop.toLowerCase().trim();
    
    // Direct lookup if available
    if (locationDistances[pickup] && locationDistances[pickup][drop] !== undefined) {
        return locationDistances[pickup][drop];
    }
    
    // Reverse lookup if available
    if (locationDistances[drop] && locationDistances[drop][pickup] !== undefined) {
        return locationDistances[drop][pickup];
    }
    
    // Default estimated distance if locations are not in our database
    return 5; // Default 5km if unknown
}

// Function to calculate price based on distance and vehicle type
function calculatePrice(pickup, drop, vehicleType) {
    const distance = calculateDistance(pickup, drop);
    const vehicle = vehicleType.toLowerCase();
    
    if (!pricePerKm[vehicle]) {
        return "Invalid vehicle type";
    }
    
    const fare = baseFare[vehicle] + (distance * pricePerKm[vehicle]);
    return Math.round(fare); // Round to nearest rupee
}

// Function to update price display
function updatePrice() {
    const pickup = document.getElementById('pickupLocation').value;
    const drop = document.getElementById('dropLocation').value;
    const vehicleType = document.getElementById('vehicleType').value;
    
    if (pickup && drop && vehicleType) {
        const price = calculatePrice(pickup, drop, vehicleType);
        document.getElementById('priceDisplay').textContent = `Rs. ${price}`;
    } else {
        document.getElementById('priceDisplay').textContent = 'Please select all fields';
    }
}

// Add event listeners when the DOM is fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Create a price display element if it doesn't exist
    if (!document.getElementById('priceDisplay')) {
        const priceLabel = document.querySelector('.book__container_main form h3:nth-child(2)');
        priceLabel.innerHTML = 'Price: <span id="priceDisplay">Select locations</span>';
    }
    
    // Add event listeners to input fields
    document.getElementById('pickupLocation').addEventListener('input', updatePrice);
    document.getElementById('dropLocation').addEventListener('input', updatePrice);
    document.getElementById('vehicleType').addEventListener('change', updatePrice);
    
    // Initialize price display
    updatePrice();
});

// Modified form submission function
function showAdditionalForm(event) {
    event.preventDefault();
    
    // Get form values
    const vehicleType = document.getElementById('vehicleType').value;
    const pickup = document.getElementById('pickupLocation').value;
    const drop = document.getElementById('dropLocation').value;
    const date = document.getElementById('bookingDate').value;
    const price = document.getElementById('priceDisplay').textContent;
    
    // Store data to use in the next step
    sessionStorage.setItem('bookingData', JSON.stringify({
        vehicleType: vehicleType,
        pickup: pickup,
        drop: drop,
        date: date,
        price: price
    }));
    
    // Redirect to the next form or show additional fields
    // For this example, we'll just alert with the data
    alert(`Booking details:\nVehicle: ${vehicleType}\nPickup: ${pickup}\nDrop: ${drop}\nDate: ${date}\nPrice: ${price}`);
    
    // Here you would normally show a confirmation form or redirect to the next step
    // Replace this with your actual form flow logic
    window.location.href = "BookingConfirmation.jsp";
}