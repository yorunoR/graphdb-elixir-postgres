import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

import BoardLayout from '@/layouts/BoardLayout.vue'
import DefaultLayout from '@/layouts/DefaultLayout.vue'
import ProjectLayout from '@/layouts/ProjectLayout.vue'
import AreaLayout from '@/layouts/project/AreaLayout.vue'
import DivisionLayout from '@/layouts/project/DivisionLayout.vue'
import TowerLayout from '@/layouts/project/TowerLayout.vue'
// import SubGraphLayout from "@/layouts/project/SubGraphLayout.vue";

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    redirect: '/project/area/towers'
  },
  {
    path: '/',
    component: DefaultLayout,
    children: [
      {
        path: 'ping',
        name: 'ping',
        component: async () =>
          await import(/* webpackChunkName: "ping" */ '@/views/PingView.vue')
      },
      {
        path: 'sign_in',
        name: 'sign_in',
        component: async () =>
          await import(
            /* webpackChunkName: "sign_in" */ '@/views/SignInView.vue'
          )
      }
    ]
  },
  {
    path: '/board',
    component: BoardLayout,
    children: [
      {
        path: 'select',
        name: 'select',
        component: async () =>
          await import(
            /* webpackChunkName: "select" */ '@/views/board/SelectView.vue'
          )
      },
      {
        path: 'about',
        name: 'about',
        component: async () =>
          await import(
            /* webpackChunkName: "about" */ '@/views/board/AboutView.vue'
          )
      }
    ]
  },
  {
    path: '/project',
    component: ProjectLayout,
    children: [
      {
        path: 'area',
        component: AreaLayout,
        children: [
          {
            path: 'towers',
            name: 'towers',
            component: async () =>
              await import(
                /* webpackChunkName: "towers" */ '@/views/project/area/TowersView.vue'
              )
          },
          {
            path: 'info',
            name: 'info',
            component: async () =>
              await import(
                /* webpackChunkName: "info" */ '@/views/project/area/InfoView.vue'
              )
          }
        ]
      },
      {
        path: 'tower/:towerId(\\d+)',
        component: TowerLayout,
        props: (route) => ({ towerId: route.params.towerId }),
        children: [
          {
            path: 'divisions',
            name: 'divisions',
            component: async () =>
              await import(
                /* webpackChunkName: "divisions" */ '@/views/project/tower/DivisionsView.vue'
              )
          },
          {
            path: 'setting',
            name: 'setting',
            component: async () =>
              await import(
                /* webpackChunkName: "setting" */ '@/views/project/tower/SettingView.vue'
              )
          }
        ]
      },
      {
        path: 'division/:divisionId(\\d+)',
        component: DivisionLayout,
        props: (route) => ({ divisionId: route.params.divisionId }),
        children: [
          {
            path: 'summary',
            name: 'summary',
            component: async () =>
              await import(
                /* webpackChunkName: "summary" */ '@/views/project/division/SummaryView.vue'
              )
          },
          {
            path: 'node_types',
            name: 'node_types',
            component: async () =>
              await import(
                /* webpackChunkName: "node_types" */ '@/views/project/division/NodeTypesView.vue'
              )
          },
          {
            path: 'edge_types',
            name: 'edge_types',
            component: async () =>
              await import(
                /* webpackChunkName: "edge_types" */ '@/views/project/division/EdgeTypesView.vue'
              )
          },
          {
            path: 'nodes',
            name: 'nodes',
            component: async () =>
              await import(
                /* webpackChunkName: "nodes" */ '@/views/project/division/NodesView.vue'
              )
          },
          {
            path: 'edges',
            name: 'edges',
            component: async () =>
              await import(
                /* webpackChunkName: "edges" */ '@/views/project/division/EdgesView.vue'
              )
          }
          // {
          //   path: "sub_graph_filters",
          //   name: "sub_graph_filters",
          //   component: async () =>
          //     await import(
          //       /* webpackChunkName: "sub_graph_filters" */ "@/views/project/division/SubGraphFiltersView.vue"
          //     ),
          // },
          // {
          //   path: "upload_csv",
          //   name: "upload_csv",
          //   component: async () =>
          //     await import(
          //       /* webpackChunkName: "upload_csv" */ "@/views/project/division/UploadCsvView.vue"
          //     ),
          // },
        ]
      }
      // {
      //   path: "sub_graph/:subGraphFilterId(\\d+)",
      //   component: SubGraphLayout,
      //   props: (route) => ({ subGraphFilterId: route.params.subGraphFilterId }),
      //   children: [
      //     {
      //       path: "search",
      //       name: "search",
      //       component: async () =>
      //         await import(
      //           /* webpackChunkName: "search" */ "@/views/project/sub_graph/SearchView.vue"
      //         ),
      //     },
      //   ],
      // },
    ]
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
