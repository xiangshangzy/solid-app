import './App.css';
import { ConfigConsul } from './lib/consul';
ConfigConsul()
const App = () => {
  return (
    <div class="content">
      <h1>Rsbuild with Solid</h1>
      <p>Start building amazing things with Rsbuild.</p>
      <h1 class="px-2 text-blue items-center justify-between">Hello world!</h1>
    </div>
  );
};

export default App;
