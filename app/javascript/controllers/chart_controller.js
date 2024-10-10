import Controller from "@hotwired/stimulus"
import Chart  from "chart.js/auto";

// import { color as colorLib } from 'chart.js/helpers';

export default class extends Controller {
  worldPopulation = {
    "men": 504,
    "women": 496
  };

  connect() { console.log("heyyyy")
    const labels = Object.keys(this.worldPopulation);
    const data = Object.values(this.worldPopulation);

    new Chart(
      this.element,
      {
        type: 'doughnut',
        data: {
          labels: labels,
          datasets: [
            {
              label: 'Gender Ratio',
              data: data,
              backgroundColor: [
                'rgb(255, 99, 132)',
                'rgb(54, 162, 235)',
                'rgb(255, 205, 86)'
              ],
              hoverOffset: 4
            }
          ]
        }
      }
    );
  }
}