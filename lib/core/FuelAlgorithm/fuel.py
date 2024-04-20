import math

def haversine(lon1, lat1, lon2, lat2):

    # Convert latitude and longitude from degrees to radians
    lon1, lat1, lon2, lat2 = map(math.radians, [lon1, lat1, lon2, lat2])

    # Haversine formula
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    radius_of_earth = 3440.065  # Radius of Earth in nautical miles (6371 km)
    distance = radius_of_earth * c
    return distance

def calculate_total_distance(coordinates):
    total_distance = 0

    # Iterate over the coordinates pairwise
    for i in range(len(coordinates) - 1):
        lat1, lon1 = coordinates[i]
        lat2, lon2 = coordinates[i + 1]
        distance = haversine(lon1, lat1, lon2, lat2)
        total_distance += distance

    return total_distance

def calculate_fuel_needed(distance_nm, consumption_rate):
    fuel_needed = distance_nm / consumption_rate
    return fuel_needed

# Input from the user for coordinates of starting and ending points
coordinate_list = []
num_coordinates = int(input("Enter the number of coordinates: "))

for i in range(num_coordinates):
    lat = float(input(f"Enter latitude for coordinate {i + 1}: "))
    lon = float(input(f"Enter longitude for coordinate {i + 1}: "))
    coordinate_list.append((lat, lon))

# Calculate total distance along the path
total_distance_nm = calculate_total_distance(coordinate_list)
print(f"The total distance along the path is approximately {total_distance_nm:.2f} nautical miles.")

# Calculate fuel needed for the trip
consumption_rate = float(input("Enter the boat's fuel consumption rate (nautical miles per gallon): "))
fuel_needed = calculate_fuel_needed(total_distance_nm, consumption_rate)
print(f"The boat will need approximately {fuel_needed:.2f} gallons of fuel for the trip.")