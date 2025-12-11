// API Service - Handles all backend communication
const API_BASE_URL = 'http://localhost:8000'; // Flask backend port

/**
 * Fetch system status
 */
export const fetchStatus = async () => {
  try {
    const response = await fetch(`${API_BASE_URL}/status`);
    
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    
    return await response.json();
  } catch (error) {
    console.error('Error fetching status:', error);
    throw error;
  }
};

/**
 * Fetch items from database
 * @param {string} type - 'aircraft', 'tasks', 'parts', or 'logs'
 * @param {object} filters - Optional filters (status, id, etc.)
 */
export const fetchItems = async (type, filters = {}) => {
  try {
    // Build query string from filters
    const params = new URLSearchParams({ type, ...filters });
    const response = await fetch(`${API_BASE_URL}/items?${params}`);
    
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    
    return await response.json();
  } catch (error) {
    console.error(`Error fetching ${type}:`, error);
    throw error;
  }
};

/**
 * Fetch aircraft list
 */
export const fetchAircraft = async (filters = {}) => {
  return fetchItems('aircraft', filters);
};

/**
 * Fetch maintenance tasks
 */
export const fetchTasks = async (filters = {}) => {
  return fetchItems('tasks', filters);
};

/**
 * Fetch parts inventory
 */
export const fetchParts = async (filters = {}) => {
  return fetchItems('parts', filters);
};