<template>
  <div class="bloco-hobby">
    <h4 class="block-title grey">Hobbies</h4>
    <div class="row">
      <div class="input-field col l5 m5 s12">
        <input type="text" id="hobby-title" class="font_20 custom-grey-text text-darken-1" v-model="hobby.title" />
        <label for="hobby-title" class="font_20 custom-grey-text text-darken-1">Título</label>
      </div>

      <div class="input-field col l4 m4 s6">
        <input type="number" class="font_20 custom-grey-text text-darken-1" id="hobby-percent" v-model="hobby.percent" min="0" max="100" />
        <label for="hobby-percent" class="font_20 custom-grey-text text-darken-1">Porcentagem</label>
      </div>

      <div class="input-field col l3 m3 s6">
        <button type="button" @click="submit()" class="btn" id="add-hobby">Adicionar</button>
      </div>
    </div>

    <div v-for="hobby in hobbies" :key="hobby.title" class="row resource-list">
      <div class="col l12 m12 s12">
        <div class="row resource-item resource-hobby">
          <div class="col l5 m5 s5 center">{{ hobby.title }}</div>
          <div class="col l1 m1 s1 center">/</div>
          <div class="col l5 m5 s5 center">{{ hobby.percent }}</div>
          <div class="col lo1 m1 s1">
            <a href="" class="fa fa-times grey-text remove-hobby" @click="removeHobby(hobby)"></a> 
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
  export default {
    props: ["portfolioId"],
    
    data() {
      return {
        hobby: {},
        hobbies: []
      }
    },

    created() {
      this.$resource('/portfolios{/portfolioId}/hobbies')
          .get({ portfolioId: this.portfolioId })
          .then(
            response => this.hobbies = (response.body.resource != null) ? response.body.resource : [],
            error => M.toast({
              html: "Ocorreu um erro ao carregar os Hobbies",
              classes: "red"
            })
          );
    },

    methods: {
      submit() {
        this.$resource('/portfolios{/portfolioId}/hobbies')
            .save(
              { portfolioId: this.portfolioId },
              { hobby: this.hobby }
            ).then(
              response => this.hobbies.push(response.body.resource),
              error => error.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      },

      removeHobby(hobby) {
        this.$resource('/portfolios{/portfolioId}/hobbies{/id}')
            .remove({
              portfolioId: this.portfolioId,
              id: hobby.id
            }).then(
              response => {
                let indexToRemove = this.hobbies.indexOf(hobby);
                this.hobbies.splice(indexToRemove, 1);
              },
              error => error.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      }
    }
  }
</script>
