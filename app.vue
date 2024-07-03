<template>
    <div class="logo">
        <a href="https://assolararmavir.am/"><img src="public/as_Solar_logo.png"></a>
    </div>
    <div class="calculator">
        <h1>Հաշվիչ</h1>
        <input v-model="priceInMount" type="number" placeholder="Ամսեկեան Հոսանքի ծախս">
        <select v-model="AnualinterestRate">
            <option disabled selected>Տոկոս</option>
            <option>0</option>
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
            <option>6</option>
        </select>
        <p>Առաջարկվող կիլովատ: {{ recommendedKWT }} կվտ</p>
        <p>Կայանի գինը: {{ priceInStation }}դր.</p>
        <p>Տոկոսադրույք: {{ AnualinterestRate }}%</p>
        <p>Տարի: 7</p>
        <p>Ամսական մոտավոր վճարում: {{ parseInt(monthlyPayment) }} դր.</p>
        <h3>Օգուտ: {{ parseInt(benefit) }} դր.</h3>
        <h3>Տարեկան Օգուտ: {{ parseInt(yearlyBenefit) }} դր.</h3>
        <strong><em><h4>Կայանի ամսեկան արտադրանք (Միջին): {{ parseInt(monthIncome) }} դր.</h4></em></strong>
        <button :disabled="!priceInMount" @click="calculation">Հաշվել</button>
    </div>
</template>

<script setup>

import { ref } from 'vue';
import { prices, monthKWT, KWTS, numberMounts } from "./utils";

// export default {
//   data() {
//     return {
//       priceInMount: '',
//       priceInStation: 0,
//       recommendedKWT: 0,
//       monthlyFee: 0,
//       benefit: 0,
//       monthIncome: 0,
//     }
//   },
//
//   methods: {
//     calculation() {
//       let indexKwt = -1;
//       const kwtStation = this.priceInMount / monthKWT;
//       let itemKwtsValue = 1;
//       KWTS.forEach((currentValue, index) => {
//         if (kwtStation >= currentValue?.kwt) {
//           indexKwt = index;
//         }
//       });
//       if (KWTS[indexKwt + 1]) {
//         itemKwtsValue = KWTS[indexKwt + 1].value;
//         this.recommendedKWT = KWTS[indexKwt + 1].kwt;
//
//         this.priceInStation = prices[itemKwtsValue];
//         this.monthlyFee = parseFloat(this.priceInStation / numberMounts);
//         this.benefit = this.priceInMount - this.monthlyFee;
//       } else {
//         alert('Свяжитесь с нами');
//       }
//
//       this.monthIncome = this.recommendedKWT * monthKWT
//     }
//   }
// }
const priceInMount = ref('');
const priceInStation = ref(0);
const recommendedKWT = ref(0);
const monthlyFee = ref(0);
const benefit = ref(0);
const monthIncome = ref(0);
const AnualinterestRate = ref(0);
const monthlyPayment = ref(0);
const yearlyBenefit = ref(0)


const calculation = () => {
    let indexKwt = -1;
    const kwtStation = priceInMount.value / monthKWT;
    let itemKwtsValue = 1;
    KWTS.forEach((currentValue, index) => {
        if (kwtStation >= currentValue?.kwt) {
            indexKwt = index;
        }
    });
    if (KWTS[indexKwt + 1]) {
        itemKwtsValue = KWTS[indexKwt + 1].value;
        recommendedKWT.value = KWTS[indexKwt + 1].kwt;
        monthIncome.value = recommendedKWT.value * monthKWT
        priceInStation.value = prices[itemKwtsValue];
        monthlyFee.value = parseFloat(priceInStation.value / numberMounts);
    } else {
        alert('Свяжитесь с нами');
    }
    const annualInterestRate = Number(AnualinterestRate.value) / 100;
    const numberOfPayments = 7 * 12;
    const monthlyInterestRate = annualInterestRate / 12;
    monthlyPayment.value =  Number(AnualinterestRate.value) ? priceInStation.value * (monthlyInterestRate * Math.pow(1 + monthlyInterestRate, numberOfPayments)) / (Math.pow(1 + monthlyInterestRate, numberOfPayments) - 1) : Number(monthlyFee.value);
    benefit.value = priceInMount.value - monthlyPayment.value;
    yearlyBenefit.value = (Number(monthIncome.value) - monthlyPayment.value)*12
};
</script>

<style scoped>
.logo{
    width: 280px;
    height: 100px;
    margin: 0 auto;
    padding: 20px;
}
.logo img{
    width: 100%;
    height: 100%;

}
.calculator {
    max-width: 450px;
    margin: 50px auto;
    padding: 20px;
    border: 2px solid #eee;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    background-color: #fff;
}

h1 {
    text-align: center;
    color: #333;
    font-size: 2em;
    margin-bottom: 20px;
}

input[type="number"] {
    width: calc(100% - 20px);
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 1em;
}

p {
    font-size: 1.1em;
    color: #555;
    margin: 10px 0;
}

button {
    width: 100%;
    padding: 15px;
    font-size: 1.2em;
    border: none;
    border-radius: 5px;
    background-color: #28a745;
    color: #fff;
    cursor: pointer;
    transition: background-color 0.3s;
}

button:hover {
    background-color: #218838;
}

button:active {
    background-color: #1e7e34;
}
select{
    width:100%;
    height: 40px;
    border: 1px solid #ddd;
    border-radius: 5px;
    color: black;
    padding: 10px;

}


@media (max-width: 768px){
    .logo{
        width: 200px;
        height: 70px;
    }
    .calculator {
        max-width: 350px;
        margin: 50px auto;
        padding: 20px;
        border: 2px solid #eee;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }
}
</style>
