package services.category;

import models.Category;
import repositories.category.CategoryRepository;
import repositories.category.ICategoryRepository;

import java.util.List;

public class CategoryService implements ICategoryService {
    private final ICategoryRepository categoryRepository = new CategoryRepository();

    @Override
    public List<Category> getAll() {
        return categoryRepository.findAll();
    }

    @Override
    public Category getById(int id) {
        return categoryRepository.findById(id);
    }

    @Override
    public boolean add(Category category) {
        return categoryRepository.save(category);
    }

    @Override
    public boolean update(Category category) {
        return categoryRepository.update(category);
    }

    @Override
    public boolean delete(int id) {
        return categoryRepository.delete(id);
    }
}
