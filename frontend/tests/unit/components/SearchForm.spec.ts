import { mount, flushPromises } from '@vue/test-utils';
import SearchForm from '@/components/SearchForm.vue';

test('allows authenticated user to edit a post', async () => {
  const mockRoute = {
    query: {
      keyword: 'リライト',
    },
  };
  const mockRouter = {
    push: jest.fn(),
  };

  const wrapper = mount(SearchForm, {
    props: {
      parentComponent: 'TopPage',
    },
    global: {
      mocks: {
        route: mockRoute,
        router: mockRouter,
      },
    },
  });

  await wrapper.find('[data-test]="search-form"').setValue('リライト');
  await wrapper.find('[data-test]="search-form-button"').trigger('click');

  expect(mockRouter.push).toHaveBeenCalledTimes(1);
  expect(mockRouter.push).toHaveBeenCalledWith('/posts/1/edit');
});
