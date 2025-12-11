import './styles/App.css';
import Header from './components/Header';
import StatusCards from './components/Status';
import AircraftTable from './components/Aircraft';
import Tabs from './components/Tabs';
import Footer from './components/Footer';

function App() {
  

  return (
    <div >
      <Header/>
      <StatusCards/>
      <Tabs/>
      <AircraftTable/>
      <Footer/>
    </div>
  );
}

export default App;