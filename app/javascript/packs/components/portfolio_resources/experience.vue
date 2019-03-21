<template>
  <div class="bloco-experiencia">
    <h4 class="block-title grey">Experiências</h4>
    <div class="row">
      <div class="input-field col l6 m6 s12">
        <input type="text" class="font_20 custom-grey-text text-darken-1"
                placeholder="Título" id="experience-title" v-model="experience.title" required />
        <label for="experience-title" class="active font_20 custom-grey-text text-darken-1">Título</label>
      </div>

      <div class="input-field col l6 m6 s12">
        <input type="text" class="font_20 custom-grey-text text-darken-1"
                placeholder="Empresa" id="experience-company" v-model="experience.company" required/>
        <label for="experience-company" class="active font_20 custom-grey-text text-darken-1">Empresa</label>
      </div>

      <div class="input-field col l12 m12 s12">
        <textarea name="experience-description" id="experience-description" v-model="experience.description"
                  class="font_20 custom-grey-text text-darken-1 materialize-textarea" required>
        </textarea>
        <label for="experience-description" class="active font_20 custom-grey-text text-darken-1">Descrição</label>
      </div>

      <div class="input-field col l4 m4 s6">
        <input data-attribute="start_date" v-model="experience.start_date" placeholder="Data de Entrada" id="experience-start-date" 
                class="datepicker-experience font_20 custom-grey-text text-darken-1" required/>
        <label for="experience-start-date" class="active font_20 custom-grey-text text-darken-1">Data de Entrada</label>
      </div>

      <div class="input-field col l4 m4 s6">
        <input data-attribute="end_date" v-model="experience.end_date" placeholder="Data de Saida" id="experience-end-date"
                class="datepicker-experience font_20 custom-grey-text text-darken-1">  
        <label for="experience-end-date" class="active font_20 custom-grey-text text-darken-1">Data de Saída</label>
      </div>

      <div class="input-field col l4 m4 s6">
        <button class="btn" type="button" id="add-experience" @click="submit()">Adicionar</button>
      </div>

    </div>

    <div class="row resource-list" :key="index" v-for="(experience, index) in experiences">
      <div class="col s12">
        <div class="row resource-item resource-experience">
          <div class="col l5 m5 s5 center">{{ experience.title }}</div>
          <div class="col l1 m1 s1 center">/</div>
          <div class="col l5 m5 s5 center">{{ experience.company }}</div>
          <div class="col l1 m1 s1">
            <a class="fa fa-times grey-text remove-experience" @click="removeExperience(experience)"></a>
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
        experience: { title: '' },
        experiences: []
      }
    },

    created() {
      this.$resource('/portfolios{/portfolioId}/experiences')
          .get({ portfolioId: this.portfolioId })
          .then(
            response => this.experiences = (response.body.resource == null ? [] : response.body.resource) ,
            error => M.toast({
              html: "Ocorreu um erro ao carregar as Experiências",
              classes: "red"
            })
          );
    },

    mounted() {
      let elems = document.querySelectorAll('.datepicker-experience');
      let vue = this;
      M.Datepicker.init(elems, {
        format: "dd/mm/yyyy",
        onClose: function() {
          console.log(this);
          let attribute = this.el.dataset.attribute;
          vue.experience[attribute] = this.el.value
        }
      });
    },

    methods: {
      submit() {
        this.$resource('/portfolios{/portfolioId}/experiences')
            .save(
              { portfolioId: this.portfolioId },
              { experience: this.experience }
            ).then(
              response => {
                this.experiences.push(response.body.resource);
                this.experience = {};
              },
              error => error.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: 'red'
                })
              )
            );
      },

      removeExperience(experience) {
        this.$resource('/portfolios{/portfolioId}/experiences{/id}')
            .remove({
              portfolioId: this.portfolioId,
              id: experience.id
            }).then(
              response => {
                let indexToRemove = this.experiences.indexOf(experience);
                this.experiences.splice(indexToRemove, 1);
              },
              error => error.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: 'red'
                })
              )
            );
      }
    }
  }
</script>