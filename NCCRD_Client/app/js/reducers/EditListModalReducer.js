'use strict'

export default function GlobalReducer(state = {}, action) {

    const { type, payload } = action

    switch (type) {

        case "SET_EDIT_LIST": {

            if (typeof payload.show === 'undefined') { payload.show = state.show }
            if (typeof payload.data === 'undefined') { payload.data = state.data }
            if (typeof payload.dispatch === 'undefined') { payload.dispatch = state.dispatch }
            if (typeof payload.persist === 'undefined') { payload.persist = state.persist }
            if (typeof payload.type === 'undefined') { payload.type = state.type }
            if (typeof payload.dependencies === 'undefined') { payload.dependencies = state.dependencies }
            if (typeof payload.newItemTemplate === 'undefined') { payload.newItemTemplate = state.newItemTemplate }

            return {
                ...state, show: payload.show, data: payload.data, dispatch: payload.dispatch, persist: payload.persist,
                type: payload.type, dependencies: payload.dependencies , newItemTemplate: payload.newItemTemplate
            }
        }

        default: {
            return state
        }

    }
}