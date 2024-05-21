<template>
    <div class="calculator">
        <h1>Հաշվիչ</h1>
        <input v-model="priceInMount" type="number" placeholder="Ամսեկեան Հոսանքի ծախս">
        <p>Առաջարկվող կիլովատ: {{ recommendedKWT }} կվտ</p>
        <p>Կայանի գինը: {{ priceInStation }}դր.</p>
        <p>Ամսական վճարում: {{ parseInt(monthlyFee) }} դր.</p>
        <h3>Օգուտ: {{ parseInt(benefit) }} դր.</h3>
        <p>Կայանի ամսեկան արտադրանք (Միջին): {{ parseInt(monthIncome) }} դր.</p>
        <button @click="calculation">Հաշվիչ</button>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import { prices, monthKWT, KWTS, numberMounts } from "./utils";

const priceInMount = ref('');
const priceInStation = ref(0);
const recommendedKWT = ref(0);
const monthlyFee = ref(0);
const benefit = ref(0);
const monthIncome = ref(0);

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

        priceInStation.value = prices[itemKwtsValue];
        monthlyFee.value = parseFloat(priceInStation.value / numberMounts);
        benefit.value = priceInMount.value - monthlyFee.value;
    } else {
        alert('Свяжитесь с нами');
    }

    monthIncome.value = recommendedKWT.value * monthKWT
};
</script>

<style scoped>
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
</style>
