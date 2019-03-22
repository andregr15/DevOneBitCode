<template>
  <div class="bloco-habilidade">
    <h4 class="block-title grey">Habilidades</h4>
    <div class="row">
      <div class="input-field col l5 m5 s12">
        <input type="text" class="font_20 custom-grey-text text-darken-1" id="skill-title" v-model="skill.title" />
        <label for="skill-title" class="font_20 custom-grey-text text-darken-1">Título</label>
      </div>

      <div class="input-field col l4 m4 s6">
        <input type="number" class="font_20 custom-grey-text-text-darken-1" id="skill-percent" v-model="skill.percent" min="0" max="100" />
        <label for="skill-percent" class="font_20 custom-grey-text text-darken-1">Porcentagem</label>
      </div>

      <div class="input-field col l3 m3 s6">
        <button class="btn" type="button" id="add-skill" @click="submit()">Adicionar</button>
      </div>
    </div>

    <div class="row resource-list" :key="skill.title" v-for="skill in skills">
      <div class="col l12 m12 s12">
        <div class="row resource-item resource-skill">
          <div class="col l5 m5 s5 center">{{ skill.title }}</div>
          <div class="col l1 m1 s1 center">/</div>
          <div class="col l5 m5 s5 center">{{ skill.percent }}</div>
          <div class="col l1 m1 s1">
            <a class="fa fa-times grey-text remove-skill" @click="removeSkill(skill)"></a>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
  export default {
    props: ['portfolioId'],

    data() {
      return {
        skill: {},
        skills: []
      }
    },

    created() {
      this.$resource('/portfolios{/portfolioId}/skills')
          .get({ portfolioId: this.portfolioId })
          .then(
            response => this.skills = (response.body.resource != null) ? response.body.resource : [],
            error => M.toast({
              html: "Ocorreu um erro ao carregar as Habilidades",
              classes: "red"
            })
          );
    },

    methods: {
      submit() {
        this.$resource('/portfolios{/portfolioId}/skills')
            .save(
              { portfolioId: this.portfolioId },
              { skill: this.skill }
            ).then(
              response => this.skills.push(response.body.resource),
              errors => errors.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      },

      removeSkill(skill) {
        this.$resource('/portfolios{/portfolioId}/skills{/id}')
            .remove({
              portfolioId: this.portfolioId,
              id: skill.id
            }).then(
              response => {
                let indexToRemove = this.skills.indexOf(skill);
                this.skills.splice(indexToRemove, 1);
              },
              errors => errors.body.errors.forEach(
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
