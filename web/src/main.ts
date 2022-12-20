// eslint-disable-next-line import/order
import PrimeVue from 'primevue/config'
import 'primeflex/primeflex.css'
import 'primeicons/primeicons.css'
import 'primevue/resources/primevue.css'
import 'primevue/resources/themes/saga-blue/theme.css'
import Button from 'primevue/button'
import Chip from 'primevue/chip'
import Column from 'primevue/column'
import DataTable from 'primevue/datatable'
import InputText from 'primevue/inputtext'
import Paginator from 'primevue/paginator'
import Panel from 'primevue/panel'
import RadioButton from 'primevue/radiobutton'
import Sidebar from 'primevue/sidebar'
import TabPanel from 'primevue/tabpanel'
import TabView from 'primevue/tabview'
import Toast from 'primevue/toast'
import ToastService from 'primevue/toastservice'
import ToggleButton from 'primevue/togglebutton'
import { createApp } from 'vue'

import App from './App.vue'
import router from './router'
import i18n from './services/i18n'
import store from './store'

createApp(App)
  .use(i18n)
  .use(router)
  .use(store)
  .use(PrimeVue)
  .use(ToastService)
  .component('Button', Button)
  .component('Chip', Chip)
  .component('Column', Column)
  .component('DataTable', DataTable)
  .component('InputText', InputText)
  .component('Paginator', Paginator)
  .component('Panel', Panel)
  .component('RadioButton', RadioButton)
  .component('Sidebar', Sidebar)
  .component('TabPanel', TabPanel)
  .component('TabView', TabView)
  .component('Toast', Toast)
  .component('ToggleButton', ToggleButton)
  .mount('#app')
