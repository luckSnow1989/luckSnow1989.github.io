package demo;

import java.io.Serializable;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
// 用于指明这个类是一个持久层的bean
public class BaseDaoImpl<T, PK extends Serializable> extends
		HibernateDaoSupport implements BaseDao<T, PK> {
	public Class entityClass;

	@Autowired
	// 必须要在使用session和transaction的类中添加这个方法，创建这个类的实例的时候，会自动注入一个sessionFactory
	public void addSessionFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}
	@SuppressWarnings("unchecked")
	public BaseDaoImpl(){
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType)genType).getActualTypeArguments();
		entityClass = (Class<T>)params[0];
	}

	public Class getEntityClass() {
		return entityClass;
	}

	public void setEntityClass(Class entityClass) {
		this.entityClass = entityClass;
	}



	public boolean insert(T t) {
		try {
			this.getHibernateTemplate().save(t);
			return true;
		} catch (RuntimeException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean delete(T t) {
		try {
			this.getHibernateTemplate().delete(t);
			return true;
		} catch (RuntimeException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean update(T t) {
		try {
			this.getHibernateTemplate().update(t);
			return true;
		} catch (RuntimeException e) {
			e.printStackTrace();
			return false;
		}
	}

	public T getById(PK pk) {
		try {
			return (T) this.getHibernateTemplate().get(entityClass, pk);
		} catch (RuntimeException e) {
			e.printStackTrace();
			return null;
		}
	}

}
